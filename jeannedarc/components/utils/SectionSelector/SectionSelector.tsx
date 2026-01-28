"use client";
import { AddIcon } from "@/components/Icons/Icons";
import styles from "./SectionSelector.module.css";
import clsx from "clsx";
import { useState } from "react";
import {
    createSectionAction,
    deleteSectionAction,
} from "@/lib/actions/actionsSection";
import { UUIDFormat } from "@/lib/schemas";
import {
    createContenuBandeauBtnAction,
    createContenuContactAction,
    createContenuImageAction,
    createContenuPaveAction,
    createContenuPdfAction,
    createContenuTexteAction,
    createContenuTitreAction,
} from "@/lib/actions/actionsContenu";
import { usePathname } from "next/navigation";
import iconStyles from "@/components/Icons/Icons.module.css";

type SectionType =
    | "Titre"
    | "Texte"
    | "BandeauBtn"
	| "TitreImage"
    | "TexteTexte"
    | "ImageTexte"
    | "Image"
	| "Contact"
    | "Pdf"
	| "PavesNav";

export function SectionSelector({ id_page_fk }: { id_page_fk: UUIDFormat }) {
    //temp
    const [editSelector, setEditSelector] = useState(false);
    const [error, setError] = useState("");
    const url = usePathname();

    const defaultJson = {
        type: "doc",
        content: [
            { type: "paragraph", content: [{ text: "(vide)", type: "text" }] },
        ],
    };
    const defaultJsonString = JSON.stringify(defaultJson);

    async function createSectionWithContent(
        sectionType: SectionType,
        id_page_fk: string,
        // eslint-disable-next-line no-unused-vars
        createContentFn: (id_section: string) => Promise<void>
    ) {
        const sectionResult = await createSectionAction({
            id_page_fk: id_page_fk,
            type: sectionType,
            revert: false,
        });
        if (!sectionResult.success) {
            // Log pour toi (dev)
            console.error("Échec de la sauvegarde:", sectionResult);

            // Message pour l'utilisateur
            if ("errors" in sectionResult) {
                setError(
                    "Les données saisies ne sont pas valides. Veuillez vérifier vos champs."
                );
            } else if ("error" in sectionResult) {
                setError(
                    "Une erreur est survenue lors de la sauvegarde. Veuillez réessayer."
                );
            }
            return;
        }
        if (sectionResult.data) {
            try {
                await createContentFn(sectionResult.data.id_section);
            } catch (error) {
                await deleteSectionAction(sectionResult.data.id_section, url, []);
                throw error;
            }
        }
    }

    async function createNewSection(sectionType: string) {
        switch (sectionType) {
            case "Titre": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTitreAction(
                            {
                                id_section_fk: id_section,
                                is_mega: false,
                                titre1: "défaut",
                                titre2: "",
                                description: "",
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "Texte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTexteAction(
                            {
                                id_section_fk: id_section,
                                tiptap_content: defaultJsonString,
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "BandeauBtn": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuBandeauBtnAction(
                            {
                                id_section_fk: id_section,
                                description: "",
                                icone: "AAAEmpty2BigIcon",
                                titre: "",
                                bouton: "défaut",
                                lien_vers: "/",
                            },
                            url
                        );
                    }
                );
                break;
            }
			case "TitreImage": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuImageAction(
                            {
                                id_section_fk: id_section,
                                image_url:
                                    "http://www.image-heberg.fr/files/1765794470531451060.png",
                                alt_text: "",
                                lien_vers: "",
                            },
                            url
                        );
                        await createContenuTitreAction(
                            {
                                id_section_fk: id_section,
                                is_mega: false,
                                titre1: "défaut",
                                titre2: "",
                                description: "",
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "TexteTexte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTexteAction(
                            {
                                id_section_fk: id_section,
                                tiptap_content: defaultJsonString,
                            },
                            url
                        );
                        await createContenuTexteAction(
                            {
                                id_section_fk: id_section,
                                tiptap_content: defaultJsonString,
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "ImageTexte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuImageAction(
                            {
                                id_section_fk: id_section,
                                image_url:
                                    "http://www.image-heberg.fr/files/1765794470531451060.png",
                                alt_text: "",
                                lien_vers: "",
                            },
                            url
                        );
                        await createContenuTexteAction(
                            {
                                id_section_fk: id_section,
                                tiptap_content: defaultJsonString,
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "Image": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuImageAction(
                            {
                                id_section_fk: id_section,
                                image_url:
                                    "http://www.image-heberg.fr/files/1765794470531451060.png",
                                alt_text: "",
                                lien_vers: "",
                            },
                            url
                        );
                    }
                );
                break;
            }
			case "Contact": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuImageAction(
                            {
                                id_section_fk: id_section,
                                image_url:
                                    "http://www.image-heberg.fr/files/1765794470531451060.png",
                                alt_text: "",
                                lien_vers: "",
                            },
                            url
                        );
                        await createContenuContactAction(
                            {
                                id_section_fk: id_section,
                                titre:"LAISSEZ-NOUS UN MESSAGE",
								champ1:"Nom et prénom",
								champ2: "Numéro de téléphone",
								champ3: "Adresse mail de contact",
								champ4: "Votre message",
								bouton: "Envoyer"
                            },
                            url
                        );
                    }
                );
                break;
            }
            case "Pdf": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuPdfAction(
                            {
                                id_section_fk: id_section,
                                pdf_url:
                                    "https://www.conseil-constitutionnel.fr/sites/default/files/2021-09/constitution.pdf",
                                pdf_titre: "titre du pdf",
                            },
                            url
                        );
                    }
                );
                break;
            }
			case "PavesNav": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuPaveAction(
                            {
                                id_section_fk: id_section,
                                titre:""
                            },
                            url
                        );
                    }
                );
                break;
            }

            default:
                break;
        }
        setEditSelector(false);
    }

    return (
        <>
            {editSelector ? (
                <div className={styles.container}>
                    <p>Sélectionnez une section</p>
                    <div className={styles.grid}>
                        <button
                            type="button"
                            onClick={() => createNewSection("Titre")}
                        >
                            Section Titre
                        </button>
                        <button
                            type="button"
                            onClick={() => createNewSection("Texte")}
                        >
                            Section Texte
                        </button>
						<button
                            type="button"
                            onClick={() => createNewSection("BandeauBtn")}
                        >
                            Section Bandeau avec bouton (ou bouton seul)
                        </button>
						<button
                            type="button"
                            onClick={() => createNewSection("TitreImage")}
                        >
                            Section TitreImage (pour page d&#39;accueil)
                        </button>
                        <button
                            type="button"
                            onClick={() => createNewSection("TexteTexte")}
                        >
                            Section TexteTexte
                        </button>
                        <button
                            type="button"
                            onClick={() => createNewSection("ImageTexte")}
                        >
                            Section ImageTexte
                        </button>
                        <button
                            type="button"
                            onClick={() => createNewSection("Image")}
                        >
                            Section Image
                        </button>
						<button
                            type="button"
                            onClick={() => createNewSection("Contact")}
                        >
                            Section Formulaire de contact
                        </button>
                        <button
                            type="button"
                            onClick={() => createNewSection("Pdf")}
                        >
                            Section Pdf
                        </button>
						<button
                            type="button"
                            onClick={() => createNewSection("PavesNav")}
                        >
                            Section Pavés de navigation
                        </button>
                        <button
                            type="button"
                            onClick={() => setEditSelector(false)}
                            className={styles.orange}
                        >
                            Annuler
                        </button>
                    </div>
                    {error && <p className={styles.error}>{error}</p>}
                </div>
            ) : (
                <div className={styles.container}>
                    <button
                        type="button"
                        onClick={() => setEditSelector(true)}
                        className={clsx(iconStyles.btnInMain, styles.center)}
                    >
                        <AddIcon className={styles.addIcon} />
                    </button>
                </div>
            )}
        </>
    );
}
