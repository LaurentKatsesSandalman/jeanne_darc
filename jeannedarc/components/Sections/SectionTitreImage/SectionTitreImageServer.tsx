"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId, getAllContenuSoloBtnsBySectionId, getAllContenuTitresBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionTitreImageClient } from "./SectionTitreImageClient";
import styles from "./SectionTitreImage.module.css";

interface SectionTitreImageProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionTitreImageServer({
    section,
    isAuth,
}: SectionTitreImageProps) {

    const rowsTitre = await getAllContenuTitresBySectionId(section.id_section);
	const rowsBtn = await getAllContenuSoloBtnsBySectionId (section.id_section)
	const rowsImage = await getAllContenuImagesBySectionId(section.id_section)
    if (!rowsTitre || !rowsImage) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuTitre = rowsTitre[0];
	const contenuImage = rowsImage[0];

    return (
        <div className={styles.sectionTitreImageBackground}>
		
            <SectionTitreImageClient
                contenuTitre={contenuTitre}
				rowsBtn = {rowsBtn}
				contenuImage={contenuImage}
                isAuth={isAuth}
                section={section}
            />
        </div>
    );
}
