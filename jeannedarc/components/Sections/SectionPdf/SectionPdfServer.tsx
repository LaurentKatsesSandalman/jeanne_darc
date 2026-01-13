"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuPdfsBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionPdfClient } from "./SectionPdfClient";
//import styles from "./SectionPdf.module.css";

interface SectionPdfProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionPdfServer({
    section,
    isAuth,
}: SectionPdfProps) {

    const rowsPdf = await getAllContenuPdfsBySectionId(section.id_section)
    if (!rowsPdf) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuPdf = rowsPdf[0];

    return (
        <>
            <SectionPdfClient
				contenuPdf={contenuPdf}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
