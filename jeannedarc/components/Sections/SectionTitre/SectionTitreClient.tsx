"use client";
import { ContenuTitreInterface } from "@/lib/definitions";
//import styles from "./SectionTitre.module.css";
import { useState } from "react";
import { ContenuTitreEdit } from "@/components/Contenus/ContenuTitre/ContenuTitreEdit";
import { ContenuTitre } from "@/components/Contenus/ContenuTitre/ContenuTitre";
import { EditIcon } from "@/components/Icons/Icons";

interface SectionTitreProps {
   contenu: ContenuTitreInterface;
    isAuth: boolean;
}

export function SectionTitreClient({ contenu, isAuth }: SectionTitreProps) {
    const [editTitre, setEditTitre] = useState(false);

	

    return (
        <>
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
                            >
                                <EditIcon/>
                            </button>
                        </>
                    )}
                    
                </>
            ) : (
                <>
                    <ContenuTitre contenu={contenu} />
                </>
            )}
        </>
    );
}
