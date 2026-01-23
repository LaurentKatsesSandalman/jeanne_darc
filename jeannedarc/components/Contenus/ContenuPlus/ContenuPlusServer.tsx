import { PageInterface, SearchIndexResult } from "@/lib/schemas";

import { getIndexByUrlAction } from "@/lib/actions/actionsIndex";
import { ResultatRecherche } from "@/components/ResultatRecherche/ResultatRecherche";


interface ContenuPlusProps{
	page: PageInterface
}

export async function ContenuPlus({page}: ContenuPlusProps) {

	const result:SearchIndexResult = await getIndexByUrlAction(page.page_url)
	if(!result || (result.success&&result.data.length === 0) || !result.success){return <p>Erreur de chargement de la page</p>}



	return (<ResultatRecherche resultat={result.data[0]}/>)
}