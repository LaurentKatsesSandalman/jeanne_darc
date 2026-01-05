"use client";
import Link from "next/link";
import styles from "./Header.module.css";
import { SectionWithBtn } from "./HeaderServer";
import { HeaderSection } from "./HeaderSection";
import { usePathname } from "next/navigation";

interface HeaderClientProps {
	isAuth: boolean;
	sections: SectionWithBtn[]
}


export function HeaderClient({isAuth, sections}:HeaderClientProps) {

	const url = usePathname()

    return (<>
{isAuth?(<div className={styles.allBtnContainer}>
	{sections.map((section)=>(
		 <HeaderSection key={section[0].id_contenu_headerbtn} section={section} url={url} />
	))}
                
            </div>):(<div className={styles.allBtnContainer}>
                <Link href="/">ACCUEIL</Link>
                <Link href="/projets/projet-pedagogique">
                    PROJET PÉDAGOGIQUE
                </Link>
                <Link href="/pre-inscriptions">PRÉ-INSCRIPTIONS</Link>
                <Link href="/plus">PLUS</Link>
                <Link href="/contact">CONTACT</Link>
            </div>)}
            
</>
        
    );
}
