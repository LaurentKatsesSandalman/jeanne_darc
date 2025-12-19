import { auth } from "@clerk/nextjs/server";
import { SectionImageTexteServer } from "@/components/Sections/SectionImageTexte/SectionImageTexteServer";
import { SectionTexteServer } from "@/components/Sections/SectionTexte/SectionTexteServer";
import { SectionTitreServer } from "@/components/Sections/SectionTitre/SectionTitreServer";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { SectionInterface } from "@/lib/schemas";
import { SectionTexteTexteServer } from "@/components/Sections/SectionTexteTexte/SectionTexteTexteServer";

interface VirtualSectionProps {
    section: SectionInterface;
    isAuth: boolean;
}

function VirtualSection({ section, isAuth }: VirtualSectionProps) {
    switch (section.type) {
        case "Titre":
            return <SectionTitreServer isAuth={isAuth} section={section} />;
        case "Texte":
            return <SectionTexteServer isAuth={isAuth} section={section} />;
        case "TexteTexte":
            return (
                <SectionTexteTexteServer isAuth={isAuth} section={section} />
            );
        case "ImageTexte":
            return (
                <SectionImageTexteServer isAuth={isAuth} section={section} />
            );
        default:
            console.warn(`Type de section inconnu: ${section.type}`);
            return null;
    }
}

export default async function Page() {
    const page = await getPageByUrl("projets/projet-pedagogique");
    if (!page) {
        return <p>Erreur au chargement de la page</p>;
    }
    const sections = await getAllSectionsByPageId(page?.id_page);
    if (!sections) {
        return <p>Erreur au chargement des sections de la page</p>;
    }

    // à mettre sur toutes les pages qui ont besoin de auth
    const { userId } = await auth();
    const isAuth = !!userId;

    return (
        <>
            <main>
                {sections?.map((section) => (
                    <VirtualSection
                        key={section.id_section}
                        section={section}
                        isAuth={isAuth}
                    />
                ))}
            </main>
        </>
    );
}
