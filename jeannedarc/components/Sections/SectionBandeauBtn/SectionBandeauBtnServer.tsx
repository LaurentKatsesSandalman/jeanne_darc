
import { SectionInterface } from "@/lib/schemas";
import { getAllContenuBandeauBtnsBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionBandeauBtnClient } from "./SectionBandeauBtnClient";
//import styles from "./SectionBandeauBtn.module.css";

interface SectionBandeauBtnProps {
    section: SectionInterface;
    isAuth: boolean;
}

export async function SectionBandeauBtnServer({
    section,
    isAuth,
}: SectionBandeauBtnProps) {

    const rowsBandeauBtn = await getAllContenuBandeauBtnsBySectionId(section.id_section)
    if (!rowsBandeauBtn) {
        return <p>Erreur au chargement du contenu</p>;
    }
    
	const contenuBandeauBtn = rowsBandeauBtn[0];

    return (
        <>
            <SectionBandeauBtnClient
				contenuBandeauBtn={contenuBandeauBtn}
                isAuth={isAuth}
                section={section}
            />
        </>
    );
}
