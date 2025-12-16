import { SectionTexteServer } from "@/components/Sections/SectionTexte/SectionTexteServer";
import { SectionTitreServer } from "@/components/Sections/SectionTitre/SectionTitreServer";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { SectionInterface } from "@/lib/schemas";

export default async function Page() {
    const page = await getPageByUrl("projets/projet-pedagogique");
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    const sections = await getAllSectionsByPageId(page?.id_page);
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }
    const sectionTitreData: SectionInterface = sections[0];
    // const sectionImageTexteData: SectionInterface = sections [1]
    const sectionTexteData: SectionInterface = sections[2];

    const isAuth = true;

    return (
        <>
            <main>
                <SectionTitreServer
                    isAuth={isAuth}
                    section={sectionTitreData}
                />
                {/* <SectionImageTexteServer/> */}
                <SectionTexteServer
                    isAuth={isAuth}
                    section={sectionTexteData}
                />
            </main>
        </>
    );
}
