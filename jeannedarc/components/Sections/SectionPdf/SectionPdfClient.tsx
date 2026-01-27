"use client";
import { ContenuPdfInterface, SectionInterface } from "@/lib/schemas";
import styles from "./SectionPdf.module.css";
import { useState } from "react";
import { EditIcon } from "@/components/Icons/Icons";
import { usePathname } from "next/navigation";
import { ContenuPdfEdit } from "@/components/Contenus/ContenuPdf/ContenuPdfEdit";
import { ContenuPdf } from "@/components/Contenus/ContenuPdf/ContenuPdf";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css";

interface SectionPdfProps {
    section: SectionInterface;
    contenuPdf: ContenuPdfInterface;
    isAuth: boolean;
}

export function SectionPdfClient({
    section,
    contenuPdf,
    isAuth,
}: SectionPdfProps) {
    const [editPdf, setEditPdf] = useState(false);
    const url = usePathname();

    return (
        <div className={styles.sectionPdfContainer}>
            {isAuth ? (
                <>
                    
                            {editPdf ? (
                                <ContenuPdfEdit
                                    contenu={contenuPdf}
                                    // isAuth={isAuth}
                                    setEditPdf={setEditPdf}
                                />
                            ) : (
                                <div>
                                    <ContenuPdf contenu={contenuPdf} />
                                    <button
                                        type="button"
                                        onClick={() => setEditPdf(true)}
                                        className={iconStyles.btnInMain}
                                    >
                                        <EditIcon />
                                    </button>
                                </div>
                            )}
                        
                    <DeleteSectionButton
                        id_section={section.id_section}
                        url={url}
                    />
                </>
            ) : (
                
                    <div>
                        <ContenuPdf contenu={contenuPdf} />
                    </div>
                
            )}
        </div>
    );
}
