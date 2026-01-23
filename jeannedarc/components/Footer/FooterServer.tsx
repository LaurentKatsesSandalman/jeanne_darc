import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { auth } from "@clerk/nextjs/server";
import styles from "./Footer.module.css";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { SectionPavesServer } from "../Sections/SectionPaves/SectionPavesServer";
import Link from "next/link";

export async function FooterServer() {
    const page = await getPageByUrl("footer");
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    const sections = await getAllSectionsByPageId(page?.id_page);
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }

    const section = sections[0];

    const { userId } = await auth();
    const isAuth = !!userId;

    const currentYear = new Date().getFullYear();

    return (
        <footer className={styles.footer}>
            <div className={styles.footerMainContainer}>
                <SectionPavesServer isAuth={isAuth} section={section} />
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2828.1527390071788!2d-0.6067899236743638!3d44.85918527360245!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd54d7e3240a645b%3A0x9f9908db53ffff58!2s43%20Rue%20Francis%20de%20Pressens%C3%A9%2C%2033110%20Le%20Bouscat!5e0!3m2!1sfr!2sfr!4v1683209618639!5m2!1sfr!2sfr%22"
                    width={250}
                    height={250}
                    allowFullScreen={true}
                    loading="lazy"
                    referrerPolicy="no-referrer-when-downgrade"
                ></iframe>
            </div>
            <p className={styles.footerCopyright}>
                © {currentYear} Institution Jeanne d&#39;Arc - Le Bouscat |{" "}
                <Link href="/mentions-legales">Mentions légales</Link>
            </p>
        </footer>
    );
}
