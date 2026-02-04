
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId, getAllContenuContactsBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionFormulaireContactClient } from "./SectionFormulaireContactClient";
//import styles from "./SectionFormulaireContact.module.css";

interface SectionFormulaireContactProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionFormulaireContactServer({
    section,
    isAuth,
}: SectionFormulaireContactProps) {

    const rowsContact = await getAllContenuContactsBySectionId(section.id_section);
	const rowsImage = await getAllContenuImagesBySectionId(section.id_section)
    if (!rowsContact || !rowsImage) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuContact = rowsContact[0];
	const contenuImage = rowsImage[0];

    return (
        <>
            <SectionFormulaireContactClient
                contenuContact={contenuContact}
				contenuImage={contenuImage}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
