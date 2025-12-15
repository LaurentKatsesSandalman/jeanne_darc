"use server";
import { SectionInterface } from "@/lib/definitions";
import { getAllContenuTitresBySectionId } from "@/lib/contentCrudContenu";
import { SectionTitreClient } from "./SectionTitreClient";
import styles from "./SectionTitre.module.css"

interface SectionTitreProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionTitreServer({
    section,
    isAuth,
}: SectionTitreProps) {
    // Use ou autre hook à utiliser
    const rows = await getAllContenuTitresBySectionId(section.id_section);
    if (!rows) {
        return <p>Erreur au chargement du contenu</p>;
    }
    const contenu = rows[0];

    return (
        <div className={styles.sectionTitreContainer}>
            <SectionTitreClient contenu={contenu} isAuth={isAuth} />
            {/*  sectionTitre ne peut pas être delete
			{isAuth && (
                <button type="button" onClick={handleDelete}>
                    <DeleteIcon />
                </button>
            )}
			*/}
        </div>
    );
}
