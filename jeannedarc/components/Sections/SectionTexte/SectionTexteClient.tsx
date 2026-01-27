"use client";
import { ContenuTexteInterface, SectionInterface } from "@/lib/schemas";
import styles from "./SectionTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { EditIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";

interface SectionTexteProps {
    section: SectionInterface;
    contenu: ContenuTexteInterface;
    isAuth: boolean;
}

export function SectionTexteClient({
    section,
    contenu,
    isAuth,
}: SectionTexteProps) {
    const [editTexte, setEditTexte] = useState(false);
    const url = usePathname();

	const ref_ids = [contenu.id_contenu_texte]

    return (
        <div className={styles.sectionTexteContainer}>
            {isAuth ? (
                <>
                    {editTexte ? (
                        <ContenuTexteEdit
                            contenu={contenu}
                            // isAuth={isAuth}
                            setEditTexte={setEditTexte}
                        />
                    ) : (
                        <>
                            <ContenuTexte contenu={contenu} />
                            <button
                                type="button"
                                onClick={() => setEditTexte(true)}
                                className={iconStyles.btnInMain}
                            >
                                <EditIcon />
                            </button>
                        </>
                    )}
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
						ref_ids={ref_ids}
                    />
                </>
            ) : (
                <>
                    <ContenuTexte contenu={contenu} />
                </>
            )}
        </div>
    );
}
