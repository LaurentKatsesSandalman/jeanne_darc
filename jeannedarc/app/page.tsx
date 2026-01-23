import { auth } from "@clerk/nextjs/server";
import { getPageByUrl } from "@/lib/queries/contentCrudPage";
import { getAllSectionsByPageId } from "@/lib/queries/contentCrudSection";
import { VirtualSection } from "@/components/utils/VirtualSection/VirtualSection";
import { SectionSelector } from "@/components/utils/SectionSelector/SectionSelector";

// export const dynamic = 'force-dynamic';
export const revalidate = 86400;

export default async function Page() {
           
        const page = await getPageByUrl("/");
        if (!page) {
            return <p>Erreur au chargement de la page ou page inexistante</p>;
        }
        const sections = await getAllSectionsByPageId(page.id_page);

        if (!sections) {
            return <p>Erreur au chargement des sections de la page ou aucune section trouvée</p>;
        }

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