"use client";
import clsx from "clsx";
import Link from "next/link";
import styles from "./Header.module.css";

import { SectionWithBtn } from "./HeaderServer";
import { ChevronDown, CloseCancelIcon, EditIcon } from "../Icons/Icons";
import { useState } from "react";
import { HeaderContentEdit } from "./HeaderContentEdit";

interface HeaderSectionProps {
    section: SectionWithBtn;
    url: string;
    isAuth: boolean;
}

export function HeaderSection({ section, url, isAuth }: HeaderSectionProps) {
    const [isEditing, setIsEditing] = useState(false);

    const otherBtns = section.slice(1);
    const currentUrl =
        (url.includes(section[0].lien_vers) && section[0].lien_vers !== "/") ||
        ((url === "" || url === "/") && section[0].lien_vers === "/");

    const [isOpen, setIsOpen] = useState(false);

    return (
        <>
            {isEditing ? (
                <div className={styles.editContainer}>
                    {section.map((btn) => (
                        <HeaderContentEdit
                            key={btn.id_contenu_headerbtn}
                            btn={btn}
                            setIsEditing={setIsEditing}
                        />
                    ))}
                    <button type="button" onClick={() => setIsEditing(false)}>
                        <CloseCancelIcon />
                    </button>
                </div>
            ) : (
                <div
                    className={styles.sectionContainer}
                    onMouseEnter={() => setIsOpen(true)}
                    onMouseLeave={() => setIsOpen(false)}
                >
                    <div
                        className={clsx(
                            styles.mainBtn,
                            currentUrl && styles.current
                        )}
                    >
                        <Link
                            href={section[0].lien_vers}
                            key={section[0].id_contenu_headerbtn}
                        >
                            {section[0].bouton}
                        </Link>
                        {otherBtns.length > 0 && (
                            <ChevronDown className={styles.inline} />
                        )}
                        {isAuth && (
                            <button
                                type="button"
                                onClick={() => setIsEditing(true)}
                            >
                                <EditIcon />
                            </button>
                        )}
                    </div>
                    {otherBtns.length > 0 && isOpen && (
                        <div className={styles.otherBtns}>
                            {otherBtns.map((btn) => (
                                <Link
                                    className={styles.otherBtn}
                                    href={btn.lien_vers}
                                    key={btn.id_contenu_headerbtn}
                                >
                                    {btn.bouton}
                                </Link>
                            ))}
                        </div>
                    )}
                </div>
            )}
        </>
    );
}
