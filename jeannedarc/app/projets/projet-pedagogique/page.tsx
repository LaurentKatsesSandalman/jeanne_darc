import { SectionTitreServer } from "@/components/Sections/SectionTitre/SectionTitreServer";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { Section } from "@/lib/schemas";

export default async function Page() {
    const page = await getPageByUrl("projets/projet-pedagogique");
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    const sections = await getAllSectionsByPageId(page?.id_page);
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }
    const sectionTitreData: Section = sections[0];
    // const sectionImageTexteData: Section = sections [1]
    // const sectionTexteData: Section = sections [2]

    const isAuth = true;

    return (
        <>
            <main>
                <SectionTitreServer
                    isAuth={isAuth}
                    section={sectionTitreData}
                />
            </main>
        </>
    );
}
