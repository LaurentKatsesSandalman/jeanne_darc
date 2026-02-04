
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionImageImageClient } from "./SectionImageImageClient";
//import styles from "./SectionImageImage.module.css";

interface SectionImageImageProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionImageImageServer({
    section,
    isAuth,
}: SectionImageImageProps) {

    const rowsImage = await getAllContenuImagesBySectionId(section.id_section);
	
    if (!rowsImage ) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuImage1 = rowsImage[0];
	const contenuImage2 = rowsImage[1];

    return (
        <>
            <SectionImageImageClient
                contenuImage1={contenuImage1}
				contenuImage2={contenuImage2}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
