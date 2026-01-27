"use client";
import { ContenuImageInterface, SectionInterface } from "@/lib/schemas";
import styles from "./SectionImage.module.css";
import { useState } from "react";
import { EditIcon } from "@/components/Icons/Icons";
import { usePathname } from "next/navigation";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css";

interface SectionImageProps {
    section: SectionInterface;
    contenuImage: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionImageClient({
    section,
    contenuImage,
    isAuth,
}: SectionImageProps) {
    const [editImage, setEditImage] = useState(false);
    const url = usePathname();

	const ref_ids = [contenuImage.id_contenu_image]


    return (
        <div className={styles.sectionImageContainer}>
            {isAuth ? (
                <>
                            {editImage ? (
                                <ContenuImageEdit
                                    contenu={contenuImage}
                                    setEditImage={setEditImage}
                                />
                            ) : (
                                <div>
                                    <ContenuImage contenu={contenuImage} />
                                    <button
                                        type="button"
                                        onClick={() => setEditImage(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
						ref_ids={ref_ids}
                    />
                </>
            ) : (
                    <div >
                        <ContenuImage contenu={contenuImage} />
                    </div>
            )}
        </div>
    );
}
