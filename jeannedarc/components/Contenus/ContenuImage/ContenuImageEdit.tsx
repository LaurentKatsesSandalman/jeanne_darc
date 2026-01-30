"use client";
import { ContenuImageInterface, UpdateContenuImage } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuImage.module.css";
import { updateContenuImageAction } from "@/lib/actions/actionsContenu";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuImageEditProps {
    contenu: ContenuImageInterface;
    setEditImage: Dispatch<SetStateAction<boolean>>;
}

export function ContenuImageEdit({
    contenu,
    setEditImage,
}: ContenuImageEditProps) {
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
        if (name === "image_url") {
            setFile(null);
            setFileName("");
        }
        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (currentContent.image_url.length < 3 && !file) {
            setError("Il doit y avoir une URL ou un fichier");
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

        if (Object.keys(payload).length === 0 && !file) {
            setEditImage(false);
            return;
        }

        if (file) {
            const formData = new FormData();
            formData.append("fileUpload", file);
            formData.append("id_contenu", contenu.id_contenu_image);

            const res = await fetch("/api/upload", {
                method: "POST",
                body: formData,
            });

            if (!res.ok) {
                const errorData = await res.json();
                if (errorData.error) {
                    setError(errorData.error);
                } else {
                    setError(
                        "Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.",
                    );
                }
                return;
            }

            payload.image_url = `/api/files/${contenu.id_contenu_image}?t=${Date.now()}`;
        }

        const result = await updateContenuImageAction(
            contenu.id_contenu_image,
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
        setEditImage(false);
    }

    return (
        <>
            <label htmlFor="image_url" className={styles.label}>
                Url de l&#39;image (optionnel)
            </label>
            <input
                type="text"
                id="image_url"
                name="image_url"
                value={currentContent.image_url}
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
                        accept="image/*"
                        // accept="application/pdf
                    />
                </label>
                <p>Fichier droppé: {fileName}</p>
            </div>

            <label htmlFor="alt_text" className={styles.label}>
                Texte alternatif
            </label>
            <input
                type="text"
                id="alt_text"
                name="alt_text"
                value={currentContent.alt_text}
                onChange={handleChange}
                className={styles.smallBorder}
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
                className={styles.smallBorder}
            />
            <CancelSaveButtons
                setEdit={setEditImage}
                handleSave={handleSave}
                error={error}
                additionalClassName={""}
            />
        </>
    );
}
