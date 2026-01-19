import { ContenuSoloBtnInterface } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ContenuSoloBtn.module.css"
import { usePathname } from "next/navigation";

interface ContenuSoloBtnProps {
	contenu: ContenuSoloBtnInterface
}

export function ContenuSoloBtn ({contenu} : ContenuSoloBtnProps ) {
const url = usePathname()

const isLocal = contenu.lien_vers.startsWith("/") 

	return (<div className={url==="/"?styles.containerSoloHome:styles.containerSolo}>
	
{isLocal?(<Link href={contenu.lien_vers} className={styles.bouton} > {contenu.bouton}
</Link>):(<a href={contenu.lien_vers} className={styles.bouton}>{contenu.bouton}</a>)}
	</div>)
}