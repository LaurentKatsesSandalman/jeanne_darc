"use client";
import clsx from "clsx";
import { ContenuImageInterface, ContenuTexteInterface, SectionInterface, UpdateSection } from "@/lib/schemas";
import styles from "./SectionImageTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { CloseCancelIcon, DeleteIcon, EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import { deleteSectionAction, updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";

interface SectionImageTexteProps {
    section: SectionInterface;
	contenuTexte: ContenuTexteInterface;
	contenuImage: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionImageTexteClient({ section, contenuTexte, contenuImage, isAuth }: SectionImageTexteProps) {
    const [editTexte, setEditTexte] = useState(false);
	const [editImage, setEditImage] = useState(false);
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
                   <div className="w-full sm:w-1/2"> {editImage ? (
                        <ContenuImageEdit
                            contenu={contenuImage}
                            // isAuth={isAuth}
                            setEditImage={setEditImage}
                        />
                    ) : (
                        <div>
                            <ContenuImage contenu={contenuImage} />
                            <button
                                type="button"
                                onClick={() => setEditImage(true)}
                            >
                                <EditIcon />
                            </button>
                        </div>
                    )}
					</div>
					<div className="w-full sm:w-1/2">
					{editTexte ? (
                        <ContenuTexteEdit
                            contenu={contenuTexte}
                            // isAuth={isAuth}
                            setEditTexte={setEditTexte}
                        />
                    ) : (
                        <div>
                            <ContenuTexte contenu={contenuTexte} />
                            <button
                                type="button"
                                onClick={() => setEditTexte(true)}
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
				<><ContenuImage contenu={contenuImage} /></>
                    
					<><ContenuTexte contenu={contenuTexte} /></>
                </div>
            )}
        </>
    );
}
