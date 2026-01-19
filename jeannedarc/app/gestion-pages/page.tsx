
import styles from "./page.module.css";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { getAllContenuHeaderBtnsBySectionId } from "@/lib/queries/contentCrudContenu";
import { SectionWithBtn } from "@/components/Header/HeaderServer";
import { SupprPagesSection } from "@/components/GestionPages/SupprPages/SupprPagesSection";
import { AjoutPageSection } from "@/components/GestionPages/AjoutPage/AjoutPageSection";
import { PageInterface, SectionInterface } from "@/lib/schemas";
//import { ContenuHeaderBtnInterface } from "@/lib/schemas";

export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default async function Page() {
let page:PageInterface|undefined;
let sections:SectionInterface[]|undefined;

try{page = await getPageByUrl("header");
	if(page){sections = await getAllSectionsByPageId(page.id_page);}
} catch (err) {
    console.warn(`Erreur de connexion BDD :`, err);
    // page reste undefined → fallback affiché
  }
    
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }

    const sectionsWithBtn: SectionWithBtn[] = [];
	// const sectionsMainBtn:ContenuHeaderBtnInterface[]=[]

    for (let i = 0; i < sections.length; i++) {
        const currentSection = await getAllContenuHeaderBtnsBySectionId(
            sections[i].id_section
        );
        if (currentSection) {
            sectionsWithBtn.push(currentSection);
			// sectionsMainBtn.push(currentSection[0])
        }
    }

    return (
        <main>
            <div className={styles.container}>
                <h1 className={styles.h1}>Gestion des pages</h1>
                <h2 className={styles.h2}>Supprimer des pages</h2>
                <div className={styles.deleteSection}>
                    {sectionsWithBtn.map((section) => (
                        <SupprPagesSection
                            key={section[0].id_contenu_headerbtn}
                            section={section}
                        />
                    ))}
                </div>
                <h2 className={styles.h2}>Ajouter des pages</h2>
				<AjoutPageSection sections={sectionsWithBtn} />
            </div>
        </main>
    );
}
