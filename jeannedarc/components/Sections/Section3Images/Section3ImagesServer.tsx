
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuImagesBySectionId } from "@/lib/queries/contentCrudContenu";
import { Section3ImagesClient } from "./Section3ImagesClient";
//import styles from "./Section3Images.module.css";

interface Section3ImagesProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function Section3ImagesServer({
    section,
    isAuth,
}: Section3ImagesProps) {

    const rowsImage = await getAllContenuImagesBySectionId(section.id_section);
	
    if (!rowsImage ) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuImage1 = rowsImage[0];
	const contenuImage2 = rowsImage[1];
	const contenuImage3 = rowsImage[2];

    return (
        <>
            <Section3ImagesClient
                contenuImage1={contenuImage1}
				contenuImage2={contenuImage2}
				contenuImage3={contenuImage3}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
