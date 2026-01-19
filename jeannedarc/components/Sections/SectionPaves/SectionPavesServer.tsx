"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuPavesBySectionId, getAllPaveBlocsByContentId } from "@/lib/queries/contentCrudContenu";
import { SectionPavesClient } from "./SectionPavesClient";
//import styles from "./SectionPaves.module.css";

interface SectionPavesProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionPavesServer({
    section,
    isAuth,
}: SectionPavesProps) {
    const rowsPaves = await getAllContenuPavesBySectionId(section.id_section);

    if (!rowsPaves) {
        return <p>Erreur au chargement du contenu</p>;
    }

	const sectionPaves = rowsPaves[0]

	const paveBlocs = await getAllPaveBlocsByContentId(sectionPaves.id_contenu_pave)

    return (
        <>
            <SectionPavesClient
                paveBlocs={paveBlocs}
				sectionPaves = {sectionPaves}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
