"use client";
import { ContenuImageInterface, UpdateContenuImage } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuImage.module.css";
import { updateContenuImageAction } from "@/lib/actions/actionsContenu";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuImageEditProps {
    contenu: ContenuImageInterface;
    // isAuth: boolean;
    setEditImage: Dispatch<SetStateAction<boolean>>;
}

export function ContenuImageEdit({
    contenu,
    /*isAuth,*/ setEditImage,
}: ContenuImageEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
    const [error, setError] = useState("");
    const url = usePathname();

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        setError("");
        const { name, value } = e.target;
        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (currentContent.image_url.length < 3) {
            setError("L'URL doit faire au moins 3 caractères");
            return;
        }

        const payload: UpdateContenuImage = {};
        if (contenu.alt_text !== currentContent.alt_text) {
            payload.alt_text = currentContent.alt_text;
        }
        if (contenu.image_url !== currentContent.image_url) {
            payload.image_url = currentContent.image_url;
        }
        if (contenu.lien_vers !== currentContent.lien_vers) {
            payload.lien_vers = currentContent.lien_vers;
        }
        if (!payload.lien_vers) {
            payload.lien_vers = "";
        }
        if (Object.keys(payload).length === 0) {
            setEditImage(false);
            return;
        }

        const result = await updateContenuImageAction(
            contenu.id_contenu_image,
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

        const updatedContenu = result.data;
        // à vérifier mais je pense que c'est complétement inutile puisque refresh path + le composant est démonté car edit passe à false
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditImage(false);
    }

    return (
        <>
            <label htmlFor="image_url" className={styles.label}>
                Url de l&#39;image
            </label>
            <input
                type="text"
                id="image_url"
                name="image_url"
                value={currentContent.image_url}
                onChange={handleChange}
            />
            <label htmlFor="alt_text" className={styles.label}>
                Texte alternatif
            </label>
            <input
                type="text"
                id="alt_text"
                name="alt_text"
                value={currentContent.alt_text}
                onChange={handleChange}
            />
            <label htmlFor="lien_vers" className={styles.label}>
                Lien vers une autre page (optionnel)
            </label>
            <input
                type="text"
                id="lien_vers"
                name="lien_vers"
                value={currentContent.lien_vers}
                onChange={handleChange}
            />
			<CancelSaveButtons setEdit={setEditImage} handleSave={handleSave} error={error} additionalClassName={""}/>
            
        </>
    );
}
