"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId, getAllContenuTextesBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionImageTexteClient } from "./SectionImageTexteClient";
import styles from "./SectionImageTexte.module.css";

interface SectionImageTexteProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionImageTexteServer({
    section,
    isAuth,
}: SectionImageTexteProps) {

    const rowsTexte = await getAllContenuTextesBySectionId(section.id_section);
	const rowsImage = await getAllContenuImagesBySectionId(section.id_section)
    if (!rowsTexte || !rowsImage) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuTexte = rowsTexte[0];
	const contenuImage = rowsImage[0];

    return (
        <div className={styles.sectionImageTexteContainer}>
            <SectionImageTexteClient
                contenuTexte={contenuTexte}
				contenuImage={contenuImage}
                isAuth={isAuth}
                section={section}
            />
        </div>
    );
}
