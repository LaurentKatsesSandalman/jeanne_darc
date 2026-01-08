"use server";
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionImageClient } from "./SectionImageClient";
import styles from "./SectionImage.module.css";

interface SectionImageProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionImageServer({
    section,
    isAuth,
}: SectionImageProps) {

    const rowsImage = await getAllContenuImagesBySectionId(section.id_section)
    if (!rowsImage) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuImage = rowsImage[0];

    return (
        <div className={styles.sectionImageContainer}>
            <SectionImageClient
				contenuImage={contenuImage}
                isAuth={isAuth}
                section={section}
            />
        </div>
    );
}
