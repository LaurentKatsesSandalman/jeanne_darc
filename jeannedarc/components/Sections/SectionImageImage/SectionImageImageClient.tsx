"use client";
import clsx from "clsx";
import {
    ContenuImageInterface,
    SectionInterface,
    UpdateSection,
} from "@/lib/schemas";
import styles from "./SectionImageImage.module.css";
import { useState } from "react";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";

interface SectionImageImageProps {
    section: SectionInterface;
    contenuImage1: ContenuImageInterface;
    contenuImage2: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionImageImageClient({
    section,
    contenuImage1,
    contenuImage2,
    isAuth,
}: SectionImageImageProps) {
    const [editImage1, setEditImage1] = useState(false);
    const [editImage2, setEditImage2] = useState(false);
    const [error, setError] = useState("");
    const url = usePathname();

	const ref_ids = [contenuImage1.id_contenu_image, contenuImage2.id_contenu_image]

    async function handleSwitchSave() {
        const payload: UpdateSection = { revert: !section.revert };
        const result = await updateSectionAction(
            section.id_section,
            payload,
            url,
        );

        if (!result.success) {
            console.error("Échec de la requête:", result);
            if ("errors" in result) {
                setError(
                    "Les données saisies ne sont pas valides. Veuillez vérifier vos champs.",
                );
            } else if ("error" in result) {
                setError(
                    "Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.",
                );
            }
            return;
        }
    }

    return (
        <div className={styles.sectionImageImageContainer}>
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
                        <div className="w-full md:w-1/2">
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
                        <div className="w-full md:w-1/2">
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
                    </div>
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
						ref_ids={ref_ids}
                    />
                    <button
                        type="button"
                        onClick={handleSwitchSave}
                        className={iconStyles.btnInMain}
                    >
                        <SwitchIcon />
                    </button>
                    {error && <p className={styles.error}>{error}</p>}
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
                    <div className="w-full md:w-1/2">
                        <ContenuImage contenu={contenuImage1} />
                    </div>

                    <div className="w-full md:w-1/2">
                        <ContenuImage contenu={contenuImage2} />
                    </div>
                </div>
            )}
        </div>
    );
}
