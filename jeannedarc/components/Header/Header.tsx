import Link from "next/link";
import styles from "./Header.module.css";
import Image from "next/image";
import logo from "../../assets/images/ECOLE_JDA_LOGO_BLANC-01-temp.png";

export function Header() {
    return (
        <header className={styles.header}>
            <Link href="/">
                <Image
                    src={logo}
                    alt="Le logo de l'école Jeanne d'Arc"
                    className={styles.logo}
					// height={94}
					// width={logo.width*94/logo.height}
                />
            </Link>
            <div className={styles.allBtnContainer}>
                <Link href="/">ACCUEIL</Link>
                <Link href="/projets/projet-pedagogique">
                    PROJET PÉDAGOGIQUE
                </Link>
                <Link href="/preinscriptions">PRÉ-INSCRIPTIONS</Link>
                <Link href="/plus">PLUS</Link>
                <Link href="/contact">CONTACT</Link>
            </div>
            <p>(+33)5 56 08 52 16</p>
        </header>
    );
}
