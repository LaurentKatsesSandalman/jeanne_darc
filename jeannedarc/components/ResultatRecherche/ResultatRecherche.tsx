import { SearchIndexProcessedData } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ResultatRecherche.module.css";

export function ResultatRecherche({
    resultat,
}: {
    resultat: SearchIndexProcessedData;
}) {
    return (
        <div className={styles.resultatRechercheContainer}>
            <Link href={resultat.page_url} >
               <p className={styles.resultTitleLink}>{resultat.page_nom}</p> 
			   <p>{resultat.extrait} </p>
            </Link>
        </div>
    );
}
