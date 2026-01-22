"use client";
import { ContenuPdfInterface, UpdateContenuPdf } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuPdf.module.css";
import { updateContenuPdfAction } from "@/lib/actions/actionsContenu";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuPdfEditProps {
    contenu: ContenuPdfInterface;
    setEditPdf: Dispatch<SetStateAction<boolean>>;
}

export function ContenuPdfEdit({ contenu, setEditPdf }: ContenuPdfEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
    const [error, setError] = useState("");
    const [file, setFile] = useState<File | null>(null);
    const [fileName, setFileName] = useState("");
    const url = usePathname();

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (e.target.files && e.target.files[0]) {
            setFile(e.target.files[0]);
            setFileName(e.target.files[0].name);
        }
    };

    const handleDrop = (e: React.DragEvent<HTMLLabelElement>) => {
        e.preventDefault();
        if (e.dataTransfer.files && e.dataTransfer.files[0]) {
            setFile(e.dataTransfer.files[0]);
            setFileName(e.dataTransfer.files[0].name);
        }
    };

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
    ) => {
        setError("");
        const { name, value } = e.target;
        if (name === "pdf_url") {
            setFile(null);
            setFileName("");
        }
        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (currentContent.pdf_url.length < 3 && !file) {
            setError("Il doit y avoir une URL ou un fichier");
            return;
        }

        const payload: UpdateContenuPdf = {};
        if (contenu.pdf_url !== currentContent.pdf_url) {
            payload.pdf_url = currentContent.pdf_url;
        }
        if (contenu.pdf_titre !== currentContent.pdf_titre) {
            payload.pdf_titre = currentContent.pdf_titre;
        }
        if (Object.keys(payload).length === 0 && !file) {
            setEditPdf(false);
            return;
        }

        if (file) {
            const formData = new FormData();
            formData.append("fileUpload", file);
            formData.append("id_contenu", contenu.id_contenu_pdf);

            const res = await fetch("/api/upload", {
                method: "POST",
                body: formData,
            });

            if (!res.ok) {
                setError(
                    "Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.",
                );
                return;
            }

            payload.pdf_url = `/api/files/${contenu.id_contenu_pdf}?t=${Date.now()}`;
        }

        const result = await updateContenuPdfAction(
            contenu.id_contenu_pdf,
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
        setEditPdf(false);
    }

    return (
        <>
            <label htmlFor="pdf_url" className={styles.label}>
                Url du pdf (optionnel)
            </label>
            <input
                type="text"
                id="pdf_url"
                name="pdf_url"
                value={currentContent.pdf_url}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<div className={styles.dropDiv}>
                <label
                    onDrop={handleDrop}
                    onDragOver={(e) => e.preventDefault()}
                    className={styles.dropBox}
                    htmlFor="file-input"
                >
                    Glisser-déposer un fichier ici ou cliquez pour sélectionner
                    <input
                        type="file"
                        id="file-input"
                        onChange={handleFileChange}
                        style={{ display: "none" }}
                        //accept="image/*"
                        accept="application/pdf"
                    />
                </label>
                <p>Fichier droppé: {fileName}</p>
            </div>
            <label htmlFor="pdf_titre" className={styles.label}>
                Titre du pdf (important)
            </label>
            <input
                type="text"
                id="pdf_titre"
                name="pdf_titre"
                value={currentContent.pdf_titre}
                onChange={handleChange}
				className={styles.smallBorder}
            />
            <CancelSaveButtons
                setEdit={setEditPdf}
                handleSave={handleSave}
                error={error}
                additionalClassName={""}
            />
        </>
    );
}
