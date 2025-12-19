import { auth } from "@clerk/nextjs/server";
import { SectionImageTexteServer } from "@/components/Sections/SectionImageTexte/SectionImageTexteServer";
import { SectionTexteServer } from "@/components/Sections/SectionTexte/SectionTexteServer";
import { SectionTitreServer } from "@/components/Sections/SectionTitre/SectionTitreServer";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { SectionInterface } from "@/lib/schemas";
import { SectionTexteTexteServer } from "@/components/Sections/SectionTexteTexte/SectionTexteTexteServer";
import { SectionSelector } from "@/components/Sections/SectionSelector/SectionSelector";

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

interface PageProps {
    params: Promise<{
    slug: string[];
  }>;
}

export default async function Page({ params }: PageProps) {
	const resolvedParams = await params;
    const url = resolvedParams.slug.join("/");

	console.log(url)

    const page = await getPageByUrl(url);
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
				{isAuth&&<SectionSelector id_page_fk={page.id_page}/>}
            </main>
        </>
    );
}
