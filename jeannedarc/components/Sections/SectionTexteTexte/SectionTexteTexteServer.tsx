"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuTextesBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionTexteTexteClient } from "./SectionTexteTexteClient";
//import styles from "./SectionTexteTexte.module.css";

interface SectionTexteTexteProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionTexteTexteServer({
    section,
    isAuth,
}: SectionTexteTexteProps) {

    const rowsTexte = await getAllContenuTextesBySectionId(section.id_section);
	
    if (!rowsTexte ) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuTexte1 = rowsTexte[0];
	const contenuTexte2 = rowsTexte[1];

    return (
        <>
            <SectionTexteTexteClient
                contenuTexte1={contenuTexte1}
				contenuTexte2={contenuTexte2}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
