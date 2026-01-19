"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuTitresBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionTitreClient } from "./SectionTitreClient";
//import styles from "./SectionTitre.module.css";

interface SectionTitreProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionTitreServer({
    section,
    isAuth,
}: SectionTitreProps) {
    const rows = await getAllContenuTitresBySectionId(section.id_section);
    if (!rows) {
        return <p>Erreur au chargement du contenu</p>;
    }
    const contenu = rows[0];

    return (
        <>
            <SectionTitreClient contenu={contenu} isAuth={isAuth} section={section}/>
        </>
    );
}
