"use client";
import clsx from "clsx";
import {
    ContenuTexteInterface,
    SectionInterface,
    UpdateSection,
} from "@/lib/schemas";
import styles from "./SectionTexteTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";

interface SectionTexteTexteProps {
    section: SectionInterface;
    contenuTexte1: ContenuTexteInterface;
    contenuTexte2: ContenuTexteInterface;
    isAuth: boolean;
}

export function SectionTexteTexteClient({
    section,
    contenuTexte1,
    contenuTexte2,
    isAuth,
}: SectionTexteTexteProps) {
    const [editTexte1, setEditTexte1] = useState(false);
    const [editTexte2, setEditTexte2] = useState(false);
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
        <div className={styles.sectionTexteTexteContainer}>
            {isAuth ? (
                <>
                    <div
                        className={clsx(
                            "flex",
                            section.revert
                                ? "flex-col-reverse sm:flex-row-reverse"
                                : "flex-col sm:flex-row"
                        )}
                    >
                        <div className="w-full sm:w-1/2">
                            
                            {editTexte1 ? (
                                <ContenuTexteEdit
                                    contenu={contenuTexte1}
                                    // isAuth={isAuth}
                                    setEditTexte={setEditTexte1}
                                />
                            ) : (
                                <div>
                                    <ContenuTexte contenu={contenuTexte1} />
                                    <button
                                        type="button"
                                        onClick={() => setEditTexte1(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                        </div>
                        <div className="w-full sm:w-1/2">
                            {editTexte2 ? (
                                <ContenuTexteEdit
                                    contenu={contenuTexte2}
                                    // isAuth={isAuth}
                                    setEditTexte={setEditTexte2}
                                />
                            ) : (
                                <div>
                                    <ContenuTexte contenu={contenuTexte2} />
                                    <button
                                        type="button"
                                        onClick={() => setEditTexte2(true)}
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
                            ? "flex-col-reverse sm:flex-row-reverse"
                            : "flex-col sm:flex-row"
                    )}
                >
                    <div className="w-full sm:w-1/2">
                        <ContenuTexte contenu={contenuTexte1} />
                    </div>

                    <div className="w-full sm:w-1/2">
                        <ContenuTexte contenu={contenuTexte2} />
                    </div>
                </div>
            )}
        </div>
    );
}
