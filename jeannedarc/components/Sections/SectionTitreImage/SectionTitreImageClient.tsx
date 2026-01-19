"use client";
import clsx from "clsx";
import {
    ContenuSoloBtnInterface,
    ContenuImageInterface,
    ContenuTitreInterface,
    SectionInterface,
    UpdateSection,
} from "@/lib/schemas";
import styles from "./SectionTitreImage.module.css";
import { useState } from "react";
import { EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import { updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css";
import { ContenuTitreEdit } from "@/components/Contenus/ContenuTitre/ContenuTitreEdit";
import { ContenuTitre } from "@/components/Contenus/ContenuTitre/ContenuTitre";
import { SectionSoloBtnClient } from "../SectionSoloBtn/SectionSoloBtnClient";
import { SectionSelectorBtnOnly } from "@/components/utils/SectionSelector/SectionSelectorBtnOnly";

interface SectionTitreImageProps {
    section: SectionInterface;
    contenuTitre: ContenuTitreInterface;
    rowsBtn?: ContenuSoloBtnInterface[];
    contenuImage: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionTitreImageClient({
    section,
    contenuTitre,
    rowsBtn,
    contenuImage,
    isAuth,
}: SectionTitreImageProps) {
    const [editTitre, setEditTitre] = useState(false);
    const [editImage, setEditImage] = useState(false);
    const [error, setError] = useState("");

    const url = usePathname();

    async function handleSwitchSave() {
        const payload: UpdateSection = { revert: !section.revert };
        const result = await updateSectionAction(
            section.id_section,
            payload,
            url
        );

        if (!result.success) {
            console.error("Échec de la requête:", result);
            if ("errors" in result) {
                setError(
                    "Les données saisies ne sont pas valides. Veuillez vérifier vos champs."
                );
            } else if ("error" in result) {
                setError(
                    "Une erreur est survenue lors de la sauvegarde. Veuillez réessayer."
                );
            }
            return;
        }
    }

    return (
        <div className={styles.sectionTitreImageContainer}>
            <div
                className={clsx(
                    "flex",
                    section.revert
                        ? "flex-col-reverse sm:flex-row-reverse"
                        : "flex-col sm:flex-row",
						styles.home
                )}
            >
                <div className="w-full sm:w-1/2">
                    {editImage ? (
                        <ContenuImageEdit
                            contenu={contenuImage}
                            // isAuth={isAuth}
                            setEditImage={setEditImage}
                        />
                    ) : (
                        <div>
                            <ContenuImage contenu={contenuImage} />
                            {isAuth && (
                                <button
                                    type="button"
                                    onClick={() => setEditImage(true)}
                                    className={iconStyles.btnInMain}
                                >
                                    <EditIcon />
                                </button>
                            )}
                        </div>
                    )}
                </div>
                <div className="w-full sm:w-1/2">
                    {editTitre ? (
                        <ContenuTitreEdit
                            contenu={contenuTitre}
                            // isAuth={isAuth}
                            setEditTitre={setEditTitre}
                        />
                    ) : (
                        <div>
                            <ContenuTitre contenu={contenuTitre} />
                            {isAuth && (
                                <button
                                    type="button"
                                    onClick={() => setEditTitre(true)}
                                    className={iconStyles.btnInMain}
                                >
                                    <EditIcon />
                                </button>
                            )}
                        </div>
                    )}
					<div className={styles.btnContainer}>
                    {rowsBtn &&
                        rowsBtn.map((contenuSoloBtn) => (
                            <SectionSoloBtnClient
                                key={contenuSoloBtn.id_contenu_solobtn}
                                contenuSoloBtn={contenuSoloBtn}
                                isAuth={isAuth}
                            />
                        ))}
                    {isAuth && <SectionSelectorBtnOnly section={section} />}
					</div>
                </div>
            </div>

            {isAuth && (
                <>
                    {" "}
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
                    />
                    <button
                        type="button"
                        onClick={handleSwitchSave}
                        className={iconStyles.btnInMain}
                    >
                        <SwitchIcon />
                    </button>{" "}
                </>
            )}
            {error && <p className={styles.error}>{error}</p>}
        </div>
    );
}
