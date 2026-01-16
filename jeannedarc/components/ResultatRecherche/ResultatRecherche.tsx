import { SearchIndexProcessedData } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ResultatRecherche.module.css"


export function ResultatRecherche({resultat}:{resultat:SearchIndexProcessedData}){

	return( <div
                            
                        >
							<Link href={resultat.page_url} className={styles.resultTitleLink} >{resultat.page_nom}</Link>
							<p>{resultat.extrait} </p>
							<Link href={resultat.page_url}>{resultat.page_url}</Link>
						</div>)
} 