import { ContenuTipTap, PageInterface } from "@/lib/definitions";
import { getTextSectionByUrl } from "../../../../lib/contentCrudPage";
import { DisplayedText } from "@/components/DisplayedText/DisplayedText";

export default async function Page() {
    const page: PageInterface | undefined = await getTextSectionByUrl(
        "editor/read"
    );
    const contenu: ContenuTipTap = page!.content;
    const check = JSON.stringify(contenu, null, 2);
    return (
        <div className="p-8">
            <p>{check}</p>
            <DisplayedText contenu={contenu} />
        </div>
    );
}
