"use client";
import styles from "./SectionSelector.module.css";
import { useState } from "react";
import {
 
} from "@/lib/actions/actionsSection";
import { SectionInterface,  } from "@/lib/schemas";
import {
	createContenuSoloBtnAction,
} from "@/lib/actions/actionsContenu";
import { usePathname } from "next/navigation";

interface SectionSelectorBtnOnlyProps{
	
	section: SectionInterface;
}


export function SectionSelectorBtnOnly({ section }: SectionSelectorBtnOnlyProps) {
    //temp
    const [editSelector, setEditSelector] = useState(false);
    const [error, setError] = useState("");
    const url = usePathname();

    async function createNewSoloBtn() {
        const result = await createContenuSoloBtnAction(
                            {
                                id_section_fk: section.id_section,
                                bouton: "défaut",
                                lien_vers: "/",
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
                            onClick={createNewSoloBtn}
							className={styles.dark}
                        >
                            bouton pour section TitreImage
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
                <div className={styles.centerTexte}>
                    <button
                        type="button"
                        onClick={() => setEditSelector(true)}
                        className={styles.centerTexte}
                    >
                        <p>(Ajouter un bouton)</p>
                    </button>
                </div>
            )}
        </>
    );
}
