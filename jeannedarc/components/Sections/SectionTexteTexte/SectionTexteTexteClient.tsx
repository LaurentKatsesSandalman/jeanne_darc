"use client";
import clsx from "clsx";
import { ContenuTexteInterface, SectionInterface, UpdateSection } from "@/lib/schemas";
import styles from "./SectionTexteTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { CloseCancelIcon, DeleteIcon, EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import { deleteSectionAction, updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";

interface SectionTexteTexteProps {
    section: SectionInterface;
	contenuTexte1: ContenuTexteInterface;
	contenuTexte2: ContenuTexteInterface;
    isAuth: boolean;
}

export function SectionTexteTexteClient({ section, contenuTexte1, contenuTexte2, isAuth }: SectionTexteTexteProps) {
    const [editTexte1, setEditTexte1] = useState(false);
	const [editTexte2, setEditTexte2] = useState(false);
    const [needConfirmation, setNeedConfirmation] = useState(false);
    const [confirmation, setConfirmation] = useState<string>("");
	const url = usePathname();

	async function handleDelete() {
		const result = await deleteSectionAction(section.id_section, url)
	
		if (!result.success) {
            throw new Error("error" in result ? result.error : "Validation error");
        }
	}

	async function handleSwitchSave(){
		const payload:UpdateSection = {revert:!section.revert}
		const result = await updateSectionAction (section.id_section, payload, url)

				if (!result.success) {
            throw new Error("error" in result ? result.error : "Validation error");
        }
	}

    return (
        <>
            {isAuth ? (
                <>
				<div className={clsx(
    "flex",
    section.revert
      ? "flex-col-reverse sm:flex-row-reverse"
      : "flex-col sm:flex-row"
  )}>
                   <div className="w-full sm:w-1/2"> {editTexte1 ? (
                        <ContenuTexteEdit
                            contenu={contenuTexte1}
                            // isAuth={isAuth}
                            setEditTexte={setEditTexte1}
                        />
                    ) : (
                        <div>
                            <ContenuTexte contenu={contenuTexte1} />
                            <button
                                type="button"
                                onClick={() => setEditTexte1(true)}
                            >
                                <EditIcon />
                            </button>
                        </div>
                    )}
					</div>
					<div className="w-full sm:w-1/2">
					{editTexte2 ? (
                        <ContenuTexteEdit
                            contenu={contenuTexte2}
                            // isAuth={isAuth}
                            setEditTexte={setEditTexte2}
                        />
                    ) : (
                        <div>
                            <ContenuTexte contenu={contenuTexte2} />
                            <button
                                type="button"
                                onClick={() => setEditTexte2(true)}
                            >
                                <EditIcon />
                            </button>
                        </div>
                    )}
					</div>
					</div>
                    {needConfirmation ? (
                       
					   <div>
						<input
					type="text"
					value={confirmation}
					onChange={(e) => setConfirmation(e.target.value)}
					placeholder="CONFIRMER"
					className={styles.confirmInput}
				/>
				<button type="button" onClick={handleDelete} disabled={confirmation !== "CONFIRMER"} ><DeleteIcon /></button>
				<button type="button" onClick={() => setNeedConfirmation(false)} ><CloseCancelIcon /></button>

						
						</div>
                    ) : (
                        <div>
                            <button
                                type="button"
                                onClick={() => setNeedConfirmation(true)}
                            >
                                <DeleteIcon />
                            </button>
                        </div>
                    )}
					<button
                                type="button"
                                onClick={handleSwitchSave}
                            >
                                <SwitchIcon />
                            </button>
                </>
            ) : (
                <div className={clsx(
    "flex",
    section.revert
      ? "flex-col-reverse sm:flex-row-reverse"
      : "flex-col sm:flex-row"
  )}>
				<div className="w-full sm:w-1/2"><ContenuTexte contenu={contenuTexte1} /></div>
                    
					<div className="w-full sm:w-1/2"><ContenuTexte contenu={contenuTexte2} /></div>
                </div>
            )}
        </>
    );
}
