"use client";
import clsx from "clsx";
import Link from "next/link";
import styles from "./Header.module.css";

import { SectionWithBtn } from "./HeaderServer";
import { ChevronDown } from "../Icons/Icons";
import { Dispatch, SetStateAction, useState } from "react";

interface HeaderSectionProps {
    section: SectionWithBtn;
    url: string;
    setModalActive: Dispatch<SetStateAction<boolean>>;
}

export function HeaderSectionMobile({
    section,
    url,
    setModalActive,
}: HeaderSectionProps) {
    const otherBtns = section.slice(1);
    const currentUrl =
        (url.includes(section[0].lien_vers) && section[0].lien_vers !== "/") ||
        ((url === "" || url === "/") && section[0].lien_vers === "/");

    const [isOpen, setIsOpen] = useState(false);

    return (
        <>
            <div className={styles.sectionContainer}>
                <div
                    className={clsx(
                        styles.mainBtn,
                        // currentUrl && styles.current,
                    )}
                >
                    <Link
                        href={section[0].lien_vers}
                        key={section[0].id_contenu_headerbtn}
                        onClick={() => setModalActive(false)}
                        className={currentUrl ? styles.current : ""}
                    >
                        {section[0].bouton}
                    </Link>
                    {otherBtns.length > 0 && (
                        <div
                            onClick={() => setIsOpen((prev) => !prev)}
                            className={clsx(styles.mobileChevron, isOpen && styles.turned)}
							tabIndex={0}
                        >
                            <ChevronDown
                                className={currentUrl ? styles.current : ""}
                            />
                        </div>
                    )}
                </div>
                {otherBtns.length > 0 && (
                    <div className={clsx(styles.otherBtns, !isOpen && styles.closed)}>
                        {otherBtns.map((btn) => (
                            <Link
                                className={styles.otherBtn}
                                href={btn.lien_vers}
                                key={btn.id_contenu_headerbtn}
                                onClick={() => setModalActive(false)}
                            >
                                {btn.bouton}
                            </Link>
                        ))}
                    </div>
                )}
            </div>
        </>
    );
}
