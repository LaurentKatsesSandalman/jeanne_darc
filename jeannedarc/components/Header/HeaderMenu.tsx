"use client";
import styles from "./Header.module.css";
import { SectionWithBtn } from "./HeaderServer";
import { HeaderSectionMobile } from "./HeaderSectionMobile";
import { usePathname } from "next/navigation";
import { Dispatch, SetStateAction } from "react";

interface HeaderClientProps {
   setModalActive: Dispatch<SetStateAction<boolean>>;
    sections: SectionWithBtn[];
}

export function HeaderMenu({  sections, setModalActive }: HeaderClientProps) {
    const url = usePathname();

    return (
        <>
            <div className={styles.allBtnContainer}>
                {sections.map((section) => (
                    <HeaderSectionMobile
                        key={section[0].id_contenu_headerbtn}
                        section={section}
                        url={url}
						setModalActive={setModalActive}
                       
                    />
                ))}
            </div>
        </>
    );
}
