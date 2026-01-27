"use client";
import clsx from "clsx";
import {
    ContenuImageInterface,
    ContenuContactInterface,
    SectionInterface,
    UpdateSection,
} from "@/lib/schemas";
import styles from "./SectionFormulaireContact.module.css";
import { useState } from "react";

import { ContenuContact } from "@/components/Contenus/ContenuContact/ContenuContact";
import { EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import { updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css";
import { ContenuContactEdit } from "@/components/Contenus/ContenuContact/ContenuContactEdit";

interface SectionFormulaireContactProps {
    section: SectionInterface;
    contenuContact: ContenuContactInterface;
    contenuImage: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionFormulaireContactClient({
    section,
    contenuContact,
    contenuImage,
    isAuth,
}: SectionFormulaireContactProps) {
    const [editContact, setEditContact] = useState(false);
    const [editImage, setEditImage] = useState(false);
    const [error, setError] = useState("");

	const ref_ids = [contenuImage.id_contenu_image, contenuContact.id_contenu_contact]

    const url = usePathname();

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
        <div className={styles.sectionFormulaireContactContainer}>
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
                            {editImage ? (
                                <ContenuImageEdit
                                    contenu={contenuImage}
                                    // isAuth={isAuth}
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
                        </div>
                        <div className="w-full md:w-1/2">
                            {editContact ? (
                                <ContenuContactEdit
                                    contenu={contenuContact}
                                    // isAuth={isAuth}
                                    setEditContact={setEditContact}
                                />
                            ) : (
                                <div>
                                    <ContenuContact contenu={contenuContact} />
                                    <button
                                        type="button"
                                        onClick={() => setEditContact(true)}
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
                        <ContenuImage contenu={contenuImage} />
                    </div>

                    <div className="w-full md:w-1/2">
                        <ContenuContact contenu={contenuContact} />
                    </div>
                </div>
            )}
        </div>
    );
}
