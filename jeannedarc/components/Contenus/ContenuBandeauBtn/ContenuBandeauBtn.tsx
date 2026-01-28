import { ContenuBandeauBtnInterface } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ContenuBandeauBtn.module.css"
import { IconDisplayer } from "@/components/utils/IconSelector/IconSelector";
import { usePathname } from "next/navigation";

interface ContenuBandeauBtnProps {
	contenu: ContenuBandeauBtnInterface
}

export function ContenuBandeauBtn ({contenu} : ContenuBandeauBtnProps ) {
const url = usePathname()

const isLocal = contenu.lien_vers.startsWith("/") 

	return (<div className={url==="/"?styles.containerBandeauHome:styles.containerBandeau}>
	{contenu.icone&&<IconDisplayer currentIcon={contenu.icone} additionalClassName={""}/>}
	{(contenu.titre||contenu.description)&&<div className={styles.containerTextes}>
		{contenu.titre&&<h2 className={styles.titre} >{contenu.titre}</h2>}
		{contenu.description&&<p className={styles.description} >{contenu.description}</p>}
		</div>}
{isLocal?(<Link href={contenu.lien_vers} className={url==="/"?styles.boutonHome:styles.bouton} > {contenu.bouton}
</Link>):(<a href={contenu.lien_vers} className={url==="/"?styles.boutonHome:styles.bouton}>{contenu.bouton}</a>)}
	</div>)
}