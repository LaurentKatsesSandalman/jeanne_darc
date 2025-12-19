"use client";
import { AddIcon } from "@/components/Icons/Icons";
import styles from "./SectionSelector.module.css";
import { useState } from "react";
import { createSectionAction, deleteSectionAction } from "@/lib/actions/actionsSection";
import { UUIDFormat } from "@/lib/schemas";
import {
    createContenuImageAction,
    createContenuTexteAction,
    createContenuTitreAction,
} from "@/lib/actions/actionsContenu";
import { usePathname } from "next/navigation";

type SectionType = "Titre" | "Texte" | "TexteTexte" | "ImageTexte";

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
        throw new Error(
            "error" in sectionResult ? sectionResult.error : "Validation error"
        );
    }
    if (sectionResult.data) {
        try {await createContentFn(sectionResult.data.id_section);}
		catch (error){
			await deleteSectionAction(sectionResult.data.id_section)
			throw error
		}
    }
}

export function SectionSelector({ id_page_fk }: { id_page_fk: UUIDFormat }) {
    const [editSelector, setEditSelector] = useState(false);
	const url = usePathname()

    const defaultJson = {
        type: "doc",
        content: [
            { type: "paragraph", content: [{ text: "(vide)", type: "text" }] },
        ],
    };
    const defaultJsonString = JSON.stringify(defaultJson);

    async function createNewSection(sectionType: string) {
        switch (sectionType) {
            case "Titre": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTitreAction({
                            id_section_fk: id_section,
                            is_mega: false,
                            titre1: "",
                            titre2: "",
                            description: "",
                        }, url);
                    }
                );
                break;
            }
			case "Texte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTexteAction({
                            id_section_fk: id_section,
                            tiptap_content: defaultJsonString,
                        }, url);
                    }
                );
                break;
            }
			case "TexteTexte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuTexteAction({
                            id_section_fk: id_section,
                            tiptap_content: defaultJsonString,
                        }, url);
                        await createContenuTexteAction({
                            id_section_fk: id_section,
                            tiptap_content: defaultJsonString,
                        }, url);
                    }
                );
                break;
            }
            case "ImageTexte": {
                await createSectionWithContent(
                    sectionType,
                    id_page_fk,
                    async (id_section) => {
                        await createContenuImageAction({
                            id_section_fk: id_section,
                            image_url: "http://www.image-heberg.fr/files/1765794470531451060.png",
                            alt_text: "",
                            lien_vers: "",
                        }, url);
                        await createContenuTexteAction({
                            id_section_fk: id_section,
                            tiptap_content: defaultJsonString,
                        }, url);
                    }
                );
                break;
            }

            default:
                break;
        }
		setEditSelector(false)
    }

    return (
        <>
            {editSelector ? (
                <>
                    <p>mettre ici toute la logique de selection</p>
                    <div>
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
                    </div>
                </>
            ) : (
                <>
                    <button type="button" onClick={() => setEditSelector(true)}>
                        <AddIcon className={styles.addIcon} />
                    </button>
                </>
            )}
        </>
    );
}
