"use client";
import { ContenuTexteInterface, SectionInterface } from "@/lib/schemas";
import styles from "./SectionTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { CloseCancelIcon, DeleteIcon, EditIcon } from "@/components/Icons/Icons";
import { deleteSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";

interface SectionTexteProps {
    id_section: SectionInterface["id_section"];
	contenu: ContenuTexteInterface;
    isAuth: boolean;
}

export function SectionTexteClient({ id_section, contenu, isAuth }: SectionTexteProps) {
    const [editTexte, setEditTexte] = useState(false);
    const [needConfirmation, setNeedConfirmation] = useState(false);
    const [confirmation, setConfirmation] = useState<string>("");
	const url = usePathname();

	async function handleDelete() {
		const result = await deleteSectionAction(id_section, url)
	
		if (!result.success) {
            throw new Error("error" in result ? result.error : "Validation error");
        }
	}

    return (
        <>
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
                            >
                                <EditIcon />
                            </button>
                        </>
                    )}
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
                </>
            ) : (
                <>
                    <ContenuTexte contenu={contenu} />
                </>
            )}
        </>
    );
}
