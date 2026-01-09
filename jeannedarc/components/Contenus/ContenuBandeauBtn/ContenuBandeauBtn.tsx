import { ContenuBandeauBtnInterface } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ContenuBandeauBtn.module.css"
import { IconDisplayer } from "@/components/utils/IconSelector/IconSelector";

interface ContenuBandeauBtnProps {
	contenu: ContenuBandeauBtnInterface
}

export function ContenuBandeauBtn ({contenu} : ContenuBandeauBtnProps ) {
const isLocal = contenu.lien_vers.startsWith("/") 

	return (<>
	{contenu.icone&&<IconDisplayer currentIcon={contenu.icone} additionalClassName={""}/>}
	{(contenu.titre||contenu.description)&&<div>
		{contenu.titre&&<p className={styles.titre} >{contenu.titre}</p>}
		{contenu.description&&<p className={styles.description} >{contenu.description}</p>}
		</div>}
{isLocal?(<Link href={contenu.lien_vers} className={styles.bouton} > {contenu.bouton}
</Link>):(<a href={contenu.lien_vers} className={styles.bouton}>{contenu.bouton}</a>)}
	</>)
}