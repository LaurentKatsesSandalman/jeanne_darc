"use client";
import styles from "./Header.module.css";
import { SectionWithBtn } from "./HeaderServer";
import { HeaderSection } from "./HeaderSection";
import { usePathname } from "next/navigation";

interface HeaderClientProps {
    isAuth: boolean;
    sections: SectionWithBtn[];
}

export function HeaderClient({ isAuth, sections }: HeaderClientProps) {
    const url = usePathname();

    return (
        <nav
            className={styles.allBtnContainer}
            aria-label="Navigation principale"
        >
            {sections.map((section) => (
                <HeaderSection
                    key={section[0].id_contenu_headerbtn}
                    section={section}
                    url={url}
                    isAuth={isAuth}
                />
            ))}
        </nav>
    );
}
