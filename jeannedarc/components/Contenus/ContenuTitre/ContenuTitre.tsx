import { ContenuTitreInterface } from "@/lib/schemas";
import styles from "./ContenuTitre.module.css"

interface ContenuTitreProps {
    contenu: ContenuTitreInterface;
}

export function ContenuTitre({ contenu }: ContenuTitreProps) {
    
	
	return (<div className={contenu.is_mega ? styles.surcontainerMega : styles.surcontainer}>
        <div className={contenu.is_mega ? styles.containerMega : styles.container}>
            {contenu.titre1 && <h1 className={contenu.is_mega ? styles.h1Mega : styles.h1}>{contenu.titre1}</h1>}
            {contenu.titre2 && <h2 className={contenu.is_mega ? styles.h2Mega : styles.h2}>{contenu.titre2}</h2>}
            {contenu.description && <p className={contenu.is_mega ? styles.descriptionMega:styles.description}>{contenu.description}</p>}
        </div>
		</div>
    );
}
