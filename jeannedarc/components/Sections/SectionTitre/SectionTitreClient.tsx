"use client";
import { ContenuTitreInterface, SectionInterface } from "@/lib/schemas";
import styles from "./SectionTitre.module.css";
import { useState } from "react";
import { ContenuTitreEdit } from "@/components/Contenus/ContenuTitre/ContenuTitreEdit";
import { ContenuTitre } from "@/components/Contenus/ContenuTitre/ContenuTitre";
import { EditIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css"
import { usePathname } from "next/navigation";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";

interface SectionTitreProps {
	section: SectionInterface;
   contenu: ContenuTitreInterface;
    isAuth: boolean;
}

export function SectionTitreClient({ section ,contenu, isAuth }: SectionTitreProps) {
    const [editTitre, setEditTitre] = useState(false);
	const url = usePathname();


    return (
        <div className={styles.sectionTitreContainer}>
            {isAuth ? (
                <>
                    {editTitre ? (
                        <ContenuTitreEdit contenu={contenu} 
						// isAuth={isAuth} 
						setEditTitre={setEditTitre}  />
                    ) : (
                        <>
                            <ContenuTitre contenu={contenu} />
                            <button
                                type="button"
                                onClick={() => setEditTitre(true)}
								className={iconStyles.btnInMain}
                            >
                                <EditIcon />
                            </button>
                        </>
                    )}
                                
                <DeleteSectionButton id_section={section.id_section} url={url}/> 
            
			
                </>
            ) : (
                <>
                    <ContenuTitre contenu={contenu} />
                </>
            )}
        </div>
    );
}
