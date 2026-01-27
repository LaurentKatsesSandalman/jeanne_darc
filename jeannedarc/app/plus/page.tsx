import { getAllPlusPages } from "@/lib/queries/contentCrudPage";
import { Metadata } from "next";
import styles from "./page.module.css";
import { ContenuPlus } from "@/components/Contenus/ContenuPlus/ContenuPlusServer";

export const revalidate = 86400;

export async function generateMetadata(): Promise<Metadata> {
    return {
        title: "Plus",
        description:
            "École Jeanne d'Arc - Le Bouscat - ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE sous CONTRAT AVEC L'ETAT",
    };
}

export default async function Page() {
    const pages = await getAllPlusPages();
    if (!pages) {
        return <p>Erreur au chargement de la page ou page inexistante</p>;
    }

    return (
        <main id="main-content">
            <div className={styles.plusPageContainer}>
                <h1 className={styles.h1}>
                    Liste des pages de la section &quot;Plus&quot;
                </h1>
                <div className={styles.resultGrid}>
                    {pages.map((page) => (
                        <ContenuPlus key={page.id_page} page={page} />
                    ))}
                </div>
            </div>
        </main>
    );
}
