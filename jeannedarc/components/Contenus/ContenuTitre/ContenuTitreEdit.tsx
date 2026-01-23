"use client";

import { ContenuTitreInterface, UpdateContenuTitre } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuTitre.module.css";

import { updateContenuTitreAction } from "@/lib/actions/actionsContenu";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuTitreEditProps {
    contenu: ContenuTitreInterface;
    // isAuth: boolean;
    setEditTitre: Dispatch<SetStateAction<boolean>>;
}

export function ContenuTitreEdit({
    contenu,
    /*isAuth,*/ setEditTitre,
}: ContenuTitreEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
    const [error, setError] = useState("");
    const url = usePathname();

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (currentContent.titre1.length < 1) {
            setError("Le Titre1 ne peut pas être vide");
            return;
        }
        const payload: UpdateContenuTitre = { is_mega: currentContent.is_mega };
        if (contenu.titre1 !== currentContent.titre1) {
            payload.titre1 = currentContent.titre1;
        }
        if (contenu.titre2 !== currentContent.titre2) {
            payload.titre2 = currentContent.titre2;
        }
        if (contenu.description !== currentContent.description) {
            payload.description = currentContent.description;
        }
        if (Object.keys(payload).length === 0) {
            setEditTitre(false);
            return;
        }

        const result = await updateContenuTitreAction(
            contenu.id_contenu_titre,
            payload,
            url
        );

        // if ("error" in result) { // comme result.error peut ne pas exister, on ne peut pas faire if(result.error)
        //     throw new Error(result.error);
        // }

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

        const updatedContenu = result.data;
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditTitre(false);
    }

    return (
        <div className={styles.container}>
            <label htmlFor="titre1" className={styles.label}>
                {currentContent.is_mega ? "Titre1 (grand)" : "Titre1 (petit)"}
            </label>
            <input
                type="text"
                id="titre1"
                name="titre1"
                value={currentContent.titre1}
                onChange={handleChange}
                className={styles.h1Edit}
            />
            <label htmlFor="titre2" className={styles.label}>
                {currentContent.is_mega
                    ? "Habituellement vide en mode Grand Titre"
                    : "Titre2 (plus grand, optionnel)"}
            </label>
            <input
                type="text"
                id="titre2"
                name="titre2"
                value={currentContent.titre2}
                onChange={handleChange}
                className={styles.h2Edit}
            />
            <label htmlFor="description" className={styles.label}>
                Description (optionnel)
            </label>
            <input
                type="text"
                id="description"
                name="description"
                value={currentContent.description}
                onChange={handleChange}
                className={styles.descriptionEdit}
            />
			<div className={styles.divGrandTitre}>
            <label htmlFor="is_mega" className={styles.labelGrandTitre}>
                Grand titre
            </label>
			<input
                type="checkbox"
                id="is_mega"
                name="is_mega"
                checked={currentContent.is_mega}
                onChange={(e) =>
                    setCurrentContent((prev) => ({
                        ...prev,
                        is_mega: e.target.checked,
                    }))
                }
                className={styles.is_mega}
            />
            </div>

            <CancelSaveButtons setEdit={setEditTitre} handleSave={handleSave} error={error} additionalClassName={""}/>
        </div>
    );
}
