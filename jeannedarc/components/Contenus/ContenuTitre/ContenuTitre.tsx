import { ContenuTitreInterface } from "@/lib/definitions";
import styles from "./ContenuTitre.module.css"

interface ContenuTitreProps {
    contenu: ContenuTitreInterface;
}

export function ContenuTitre({ contenu }: ContenuTitreProps) {
    
	
	return (
        <>
            {contenu.titre1 && <h1 className={styles.h1}>{contenu.titre1}</h1>}
            {contenu.titre2 && <h2 className={styles.h2}>{contenu.titre2}</h2>}
            {contenu.description && <p className={styles.description}>{contenu.description}</p>}
        </>
    );
}
