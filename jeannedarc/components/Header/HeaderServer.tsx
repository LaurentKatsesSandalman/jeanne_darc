

import Link from "next/link";
import styles from "./Header.module.css";
import Image from "next/image";
// import logo from "/public/ECOLE_JDA_LOGO_BLANC-01-temp.png";
//import { SignOutButton } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { LogoutButton } from "../Buttons/LogoutButton/LogoutButton";
import { HeaderClient } from "./HeaderClient";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { getAllContenuHeaderBtnsBySectionId } from "@/lib/queries/contentCrudContenu";
import { RechercheClient } from "../Recherche/RechercheClient";
import { HeaderMobileClient } from "./HeaderMobileClient";

export type SectionWithBtn = ContenuHeaderBtnInterface[];

export async function HeaderServer() {
    const page = await getPageByUrl("header");
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    const sections = await getAllSectionsByPageId(page?.id_page);
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }

    const sectionsWithBtn: SectionWithBtn[] = [];

    for (let i = 0; i < sections.length; i++) {
        const currentSection = await getAllContenuHeaderBtnsBySectionId(
            sections[i].id_section,
        );
        if (currentSection) {
            sectionsWithBtn.push(currentSection);
        }
    }

    const { userId } = await auth();
    const isAuth = !!userId;

    return (
        <header>
            <div className={styles.header}>
                <Link href="/" className={styles.logoContainer}>
                    <Image
                        src="/ECOLE_JDA_LOGO_BLANC-01-temp.png"
                        alt="Le logo de l'école Jeanne d'Arc"
                        className={styles.logo}
						    fill
                    />
                </Link>
                <HeaderClient isAuth={isAuth} sections={sectionsWithBtn} />
                <a href="tel:+33556085216">(+33)5 56 08 52 16</a>
                <RechercheClient />
            </div>
			<div className={styles.headerMobile}>
               <RechercheClient />
			    <Link href="/" className={styles.logoContainerMobile}>
                    <Image
                        src="/ECOLE_JDA_LOGO_BLANC-01-temp.png"
                        alt="Le logo de l'école Jeanne d'Arc"
                        className={styles.logo}
						    fill
                    />
                </Link>
				<HeaderMobileClient sectionsWithBtn={sectionsWithBtn} />
                
                
            </div>
            {isAuth && (
                <>
                    <LogoutButton />
                    <Link href="/gestion-pages" className={styles.auth}>
                        Gestion des pages
                    </Link>
                </>
            )}
        </header>
    );
}
