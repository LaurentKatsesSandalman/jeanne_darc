import { Contenu } from '@/lib/definitions';
import { getTextSectionByUrl } from '../../../lib/contentCrud';
import {DisplayedText} from "@/components/DisplayedText/DisplayedText";

export default async function Page() {
 const page = await getTextSectionByUrl ("projet-pedagogique")
 const contenu:Contenu = page.content

    return (
        <div className="p-8">
                        <DisplayedText contenu={contenu}/>
        </div>
    );
}
