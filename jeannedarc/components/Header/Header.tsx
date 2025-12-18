"use server";
import Link from "next/link";
import styles from "./Header.module.css";
import Image from "next/image";
import logo from "../../assets/images/ECOLE_JDA_LOGO_BLANC-01-temp.png";
//import { SignOutButton } from "@clerk/nextjs";
import { auth } from "@clerk/nextjs/server";
import { LogoutButton } from "../Buttons/LogoutButton/LogoutButton";

export async function Header() {
    const { userId } = await auth();
    const isAuth = !!userId;

    return (
        <header ><div className={styles.header}>
            <Link href="/">
                <Image
                    src={logo}
                    alt="Le logo de l'école Jeanne d'Arc"
                    className={styles.logo}
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
            <p>(+33)5 56 08 52 16</p></div>
            {isAuth && (
                <LogoutButton/>
            )}
        </header>
    );
}
