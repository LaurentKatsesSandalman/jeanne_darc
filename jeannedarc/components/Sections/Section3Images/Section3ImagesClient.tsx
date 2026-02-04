"use client";
import clsx from "clsx";
import {
    ContenuImageInterface,
    SectionInterface,
} from "@/lib/schemas";
import styles from "./Section3Images.module.css";
import { useState } from "react";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { EditIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";

interface Section3ImagesProps {
    section: SectionInterface;
    contenuImage1: ContenuImageInterface;
    contenuImage2: ContenuImageInterface;
	contenuImage3: ContenuImageInterface;
    isAuth: boolean;
}

export function Section3ImagesClient({
    section,
    contenuImage1,
    contenuImage2,
	contenuImage3,
    isAuth,
}: Section3ImagesProps) {
    const [editImage1, setEditImage1] = useState(false);
    const [editImage2, setEditImage2] = useState(false);
	 const [editImage3, setEditImage3] = useState(false);
    // const [error, setError] = useState("");
    const url = usePathname();

	const ref_ids = [contenuImage1.id_contenu_image, contenuImage2.id_contenu_image, contenuImage3.id_contenu_image]



    return (
        <div className={styles.section3ImagesContainer}>
            {isAuth ? (
                <>
                    <div
                        className={clsx(
                            "flex",
                            section.revert
                                ? "gap-15 flex-col-reverse md:flex-row-reverse"
                                : "gap-15 flex-col md:flex-row",
                        )}
                    >
                        <div className="w-full md:w-1/3">
                            {editImage1 ? (
                                <ContenuImageEdit
                                    contenu={contenuImage1}
                                    // isAuth={isAuth}
                                    setEditImage={setEditImage1}
                                />
                            ) : (
                                <div>
                                    <ContenuImage contenu={contenuImage1} />
                                    <button
                                        type="button"
                                        onClick={() => setEditImage1(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                        </div>
                        <div className="w-full md:w-1/3">
                            {editImage2 ? (
                                <ContenuImageEdit
                                    contenu={contenuImage2}
                                    // isAuth={isAuth}
                                    setEditImage={setEditImage2}
                                />
                            ) : (
                                <div>
                                    <ContenuImage contenu={contenuImage2} />
                                    <button
                                        type="button"
                                        onClick={() => setEditImage2(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                        </div>
						<div className="w-full md:w-1/3">
                            {editImage3 ? (
                                <ContenuImageEdit
                                    contenu={contenuImage3}
                                    // isAuth={isAuth}
                                    setEditImage={setEditImage3}
                                />
                            ) : (
                                <div>
                                    <ContenuImage contenu={contenuImage3} />
                                    <button
                                        type="button"
                                        onClick={() => setEditImage3(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                        </div>
                    </div>
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
						ref_ids={ref_ids}
                    />
                    {/* <button
                        type="button"
                        onClick={handleSwitchSave}
                        className={iconStyles.btnInMain}
                    >
                        <SwitchIcon />
                    </button>
                    {error && <p className={styles.error}>{error}</p>} */}
                </>
            ) : (
                <div
                    className={clsx(
                        "flex",
                        section.revert
                            ? "gap-15 flex-col-reverse md:flex-row-reverse"
                            : "gap-15 flex-col md:flex-row",
                    )}
                >
                    <div className="w-full md:w-1/3">
                        <ContenuImage contenu={contenuImage1} />
                    </div>

                    <div className="w-full md:w-1/3">
                        <ContenuImage contenu={contenuImage2} />
                    </div>

					 <div className="w-full md:w-1/3">
                        <ContenuImage contenu={contenuImage3} />
                    </div>
                </div>
            )}
        </div>
    );
}
