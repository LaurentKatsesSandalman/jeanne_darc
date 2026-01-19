import { auth } from "@clerk/nextjs/server";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { SectionSelector } from "@/components/utils/SectionSelector/SectionSelector";
import { VirtualSection } from "@/components/utils/VirtualSection/VirtualSection";

interface PageProps {
    params: Promise<{
        slug: string[];
    }>;
}

// export const dynamic = 'force-dynamic';
export const revalidate = 3600;

export default async function Page({ params }: PageProps) {
    const resolvedParams = await params;
    const url = resolvedParams.slug.join("/");

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
                {isAuth && <SectionSelector id_page_fk={page.id_page} />}
            </main>
        </>
    );
}
