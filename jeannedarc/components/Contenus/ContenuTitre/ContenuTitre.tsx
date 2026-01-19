import { ContenuTitreInterface } from "@/lib/schemas";
import styles from "./ContenuTitre.module.css"
import { usePathname } from "next/navigation";

interface ContenuTitreProps {
    contenu: ContenuTitreInterface;
}

export function ContenuTitre({ contenu }: ContenuTitreProps) {
	const url = usePathname()
    
	
	return (<>{url==="/"?(<>
	<div className={styles.surcontainerHome}>
        <div className={styles.containerHome}>
            {contenu.titre1 && <h1 className={styles.h1Home}>{contenu.titre1}</h1>}
            {contenu.titre2 && <h2 className={styles.h2Home}>{contenu.titre2}</h2>}
            {contenu.description && <p className={styles.descriptionHome}>{contenu.description}</p>}
        </div>
		</div>
	
	
	</>):(<div className={contenu.is_mega ? styles.surcontainerMega : styles.surcontainer}>
        <div className={contenu.is_mega ? styles.containerMega : styles.container}>
            {contenu.titre1 && <h1 className={contenu.is_mega ? styles.h1Mega : styles.h1}>{contenu.titre1}</h1>}
            {contenu.titre2 && <h2 className={contenu.is_mega ? styles.h2Mega : styles.h2}>{contenu.titre2}</h2>}
            {contenu.description && <p className={contenu.is_mega ? styles.descriptionMega:styles.description}>{contenu.description}</p>}
        </div>
		</div>)}</>
    );
}
