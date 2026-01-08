"use client";
import { CloseCancelIcon, SaveIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { ContenuPdfInterface, UpdateContenuPdf } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuPdf.module.css";
import { updateContenuPdfAction } from "@/lib/actions/actionsContenu";

interface ContenuPdfEditProps {
    contenu: ContenuPdfInterface;
    setEditPdf: Dispatch<SetStateAction<boolean>>;
}

export function ContenuPdfEdit({ contenu, setEditPdf }: ContenuPdfEditProps) {
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
        const payload: UpdateContenuPdf = {};
        if (contenu.pdf_url !== currentContent.pdf_url) {
            payload.pdf_url = currentContent.pdf_url;
        }
        if (contenu.pdf_titre !== currentContent.pdf_titre) {
            payload.pdf_titre = currentContent.pdf_titre;
        }
        if (Object.keys(payload).length === 0) {
            setEditPdf(false);
            return;
        }

        const result = await updateContenuPdfAction(
            contenu.id_contenu_pdf,
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
                setError("Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.");
            }
            return;
        }

        const updatedContenu = result.data;
        // à vérifier mais je pense que c'est complétement inutile puisque refresh path + le composant est démonté car edit passe à false
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditPdf(false);
    }

    return (
        <>
            <label htmlFor="pdf_url" className={styles.label}>
                Url du pdf
            </label>
            <input
                type="text"
                id="pdf_url"
                name="pdf_url"
                value={currentContent.pdf_url}
                onChange={handleChange}
            />
            <label htmlFor="pdf_titre" className={styles.label}>
                Titre du pdf
            </label>
            <input
                type="text"
                id="pdf_titre"
                name="pdf_titre"
                value={currentContent.pdf_titre}
                onChange={handleChange}
            />

            <div>
                <button
                    type="button"
                    onClick={() => setEditPdf(false)}
                    className={iconStyles.btnInMain}
                >
                    <CloseCancelIcon />
                </button>
                <button
                    type="button"
                    onClick={handleSave}
                    className={iconStyles.btnInMain}
                >
                    <SaveIcon />
                </button>
				{error&&<p>{error}</p>}
            </div>
            <p>{currentContent.pdf_url}</p>
            <p>{currentContent.pdf_titre}</p>
        </>
    );
}
