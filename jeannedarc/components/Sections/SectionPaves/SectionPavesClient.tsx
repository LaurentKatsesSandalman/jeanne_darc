"use client";
import {
    ContenuPaveInterface,
    PaveBlocInterface,
    SectionInterface,
    UpdateContenuPave,
} from "@/lib/schemas";
import { SectionPaveClient } from "./SectionPaveClient";
import styles from "./SectionPaves.module.css";
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import { EditIcon } from "@/components/Icons/Icons";
import {
    createPaveBlocAction,
    updateContenuPaveAction,
} from "@/lib/actions/actionsContenu";
import { useState } from "react";
import iconStyles from "@/components/Icons/Icons.module.css";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface SectionPavesProps {
    section: SectionInterface;
    sectionPaves: ContenuPaveInterface;
    paveBlocs?: PaveBlocInterface[];
    isAuth: boolean;
}

export function SectionPavesClient({
    section,
    sectionPaves,
    paveBlocs,
    isAuth,
}: SectionPavesProps) {
    const [error, setError] = useState("");
    const [editTitre, setEditTitre] = useState(false);
    const [currentContent, setCurrentContent] = useState(sectionPaves);
    const url = usePathname();

	const ref_ids = [sectionPaves.id_contenu_pave]

    async function createNewBloc() {
        const result = await createPaveBlocAction(
            {
                id_contenu_pave_fk: sectionPaves.id_contenu_pave,
                icone: "BigAtBigIcon",
                soustitre: "Titre",
                description1: "description",
                description2: "",
                description3: "",
                description4: "",
                description5: "",
                description6: "",
                description7: "",
                lien_vers: "",
            },
            url
        );
        if (!result.success) {
            // Log pour toi (dev)
            console.error("Échec de la sauvegarde:", result);

            // Message pour l'utilisateur
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
        const payload: UpdateContenuPave = {};
        if (sectionPaves.titre !== currentContent.titre) {
            payload.titre = currentContent.titre;
        }

        if (Object.keys(payload).length === 0) {
            setEditTitre(false);
            return;
        }

        const result = await updateContenuPaveAction(
            sectionPaves.id_contenu_pave,
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
        setEditTitre(false);
    }

	    const isContactPage = url.startsWith("/contact");
    const isHome = url === "/";

    const classSuffixe = isContactPage ? "Contact" : isHome ? "Home" : "";

    return (
        <div className={styles[`sectionPavesContainer${classSuffixe}`]}>
            {editTitre ? (
                <>
                    <label htmlFor="titre" className={styles.label}>
                        Titre
                    </label>
                    <input
                        type="text"
                        id="titre"
                        name="titre"
                        value={currentContent.titre}
                        onChange={handleChange}
                    />
                    <CancelSaveButtons
                        setEdit={setEditTitre}
                        handleSave={handleSave}
                        error={error}
                        additionalClassName={""}
                    />
                </>
            ) : (
                <>
                    {sectionPaves.titre ? (
                        <>
                            <h2 className={styles[`h2Pave${classSuffixe}`]}>{sectionPaves.titre}</h2>
                            {isAuth && (
                                <button
                                    type="button"
                                    onClick={() => setEditTitre(true)}
                                    className={iconStyles.btnInMain}
                                >
                                    <EditIcon />
                                </button>
                            )}
                        </>
                    ) : (
                        <>
                            {isAuth && (
                                <button
                                    type="button"
                                    onClick={() => setEditTitre(true)}
									className={styles[`texteBtnPave${classSuffixe}`]}
                                >
                                    (ajouter un titre)
                                </button>
                            )}
                        </>
                    )}
                </>
            )}

            <div className={styles[`blocsContainer${classSuffixe}`]}>
                {paveBlocs && (
                    <>
                        {paveBlocs.map((paveBloc) => (
                            <SectionPaveClient
                                key={paveBloc.id_pave_bloc}
                                paveBloc={paveBloc}
                                isAuth={isAuth}
                            />
                        ))}
                    </>
                )}
                
            </div>
			{isAuth && (
                    <>
                        <button type="button" onClick={createNewBloc} className={styles[`texteBtnPave${classSuffixe}`]}>
                            (ajouter un bloc)
                        </button>
                        <DeleteSectionButton
                            id_section={section.id_section}
                            url={url}
							ref_ids={ref_ids}
                        />
                        {error && <p className={styles.error}>{error}</p>}
                    </>
                )}
        </div>
    );
}
