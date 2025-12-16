"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuTextesBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionTexteClient } from "./SectionTexteClient";
import styles from "./SectionTexte.module.css";

interface SectionTexteProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionTexteServer({
    section,
    isAuth,
}: SectionTexteProps) {
    // Use ou autre hook à utiliser
    const rows = await getAllContenuTextesBySectionId(section.id_section);
    if (!rows) {
        return <p>Erreur au chargement du contenu</p>;
    }
    const contenu = rows[0];

    return (
        <div className={styles.sectionTexteContainer}>
            <SectionTexteClient contenu={contenu} isAuth={isAuth} id_section={section.id_section}/>			
        </div>
    );
}