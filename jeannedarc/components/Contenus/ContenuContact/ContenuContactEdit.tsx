"use client";
import { ContenuContactInterface, UpdateContenuContact } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuContact.module.css";
import { updateContenuContactAction } from "@/lib/actions/actionsContenu";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuContactEditProps {
    contenu: ContenuContactInterface;
    setEditContact: Dispatch<SetStateAction<boolean>>;
}

export function ContenuContactEdit({
    contenu,
    setEditContact,
}: ContenuContactEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
    const [error, setError] = useState("");
    const url = usePathname();

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
    ) => {
        setError("");
        const { name, value } = e.target;

        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (
            currentContent.champ1.length < 3 ||
            currentContent.champ2.length < 3 ||
            currentContent.champ3.length < 3 ||
            currentContent.champ4.length < 3
        ) {
            setError(
                "Il doit y avoir 4 champs et leur titre doit faire au moins 3 caractères",
            );
            return;
        }

        const notUpdateKeys = [
            "id_contenu_contact",
            "id_section_fk",
            "created_at",
            "updated_at",
        ] as const;

        type NotUpdatedKeys = (typeof notUpdateKeys)[number]; //number = quel que soit l'index ; ce type transform le tableau littéral en une collection de 4 littéraux
        type UpdateKeys = Exclude<keyof typeof contenu, NotUpdatedKeys>;

        const payload: UpdateContenuContact = {};
        (Object.keys(contenu) as Array<keyof typeof contenu>).forEach((key) => {
            if (!notUpdateKeys.includes(key as NotUpdatedKeys)) {
                const updateKey = key as UpdateKeys;
                if (contenu[updateKey] !== currentContent[updateKey]) {
                    payload[updateKey] = currentContent[
                        updateKey
                    ] as UpdateContenuContact[UpdateKeys];
                }
            }
        });

        if (Object.keys(payload).length === 0) {
            setEditContact(false);
            return;
        }

        const result = await updateContenuContactAction(
            contenu.id_contenu_contact,
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

        const updatedContenu = result.data;
        // à vérifier mais je pense que c'est complétement inutile puisque refresh path + le composant est démonté car edit passe à false
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditContact(false);
    }

    return (
        <>
            <p>Dans la structure actuelle, il doit toujours y avoir 4 champs (dont le dernier est le champ message) et aucun titre de champ ne peut faire moins de 3 caractères</p>
			<label htmlFor="champ1" className={styles.label}>
                L&#39;information demandée dans le premier champ
            </label>
            <input
                type="text"
                id="champ1"
                name="champ1"
                value={currentContent.champ1}
                onChange={handleChange}
                className={styles.smallBorder}
            />
			<label htmlFor="champ2" className={styles.label}>
                L&#39;information demandée dans le deuxième champ
            </label>
            <input
                type="text"
                id="champ2"
                name="champ2"
                value={currentContent.champ2}
                onChange={handleChange}
                className={styles.smallBorder}
            />
			<label htmlFor="champ3" className={styles.label}>
                L&#39;information demandée dans le troisième champ
            </label>
            <input
                type="text"
                id="champ3"
                name="champ3"
                value={currentContent.champ3}
                onChange={handleChange}
                className={styles.smallBorder}
            />
			<label htmlFor="champ4" className={styles.label}>
                Pour le quatrième champ, vous devriez utiliser &quot;Message&quot; ou quelque chose d&#39;équivalent
            </label>
            <input
                type="text"
                id="champ3"
                name="champ3"
                value={currentContent.champ3}
                onChange={handleChange}
                className={styles.smallBorder}
            />
           
            <CancelSaveButtons
                setEdit={setEditContact}
                handleSave={handleSave}
                error={error}
                additionalClassName={""}
            />
        </>
    );
}
