"use client";
import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { CloseCancelIcon, DeleteIcon } from "../../Icons/Icons";
import clsx from "clsx";
import styles from "./SupprPages.module.css";
import iconStyles from "@/components/Icons/Icons.module.css"
import { deletePageAction } from "@/lib/actions/actionsPage";
import { usePathname } from "next/navigation";
import { useState } from "react";
import { getAllContenuHeaderBtnsBySectionId } from "@/lib/queries/contentCrudContenu";
import { updateContenuHeaderBtnAction } from "@/lib/actions/actionsContenu";

interface SupprPagesContentEditProps {
    btn: ContenuHeaderBtnInterface;
}

export function SupprPagesContentEdit({ btn }: SupprPagesContentEditProps) {
    const [needConfirmation, setNeedConfirmation] = useState(false);
	const [confirmation, setConfirmation] = useState<string>("");
	
	
	const url = usePathname();

    async function handleDelete() {
		const position = btn.position
		const section = btn.id_section_fk
        const deletePageResult = await deletePageAction(btn.id_page_fk, url);

        if (!deletePageResult.success) {
            throw new Error(
                "error" in deletePageResult
                    ? deletePageResult.error
                    : "Validation error"
            );
        }

		const buttons = await getAllContenuHeaderBtnsBySectionId (section)
		if(buttons){
			for (const button of buttons){
				if(button.position>position){
					const updatePositionResult = await updateContenuHeaderBtnAction(button.id_contenu_headerbtn,{position:button.position-1})
					if (!updatePositionResult.success) {
            throw new Error(
                "error" in updatePositionResult
                    ? updatePositionResult.error
                    : "Validation error"
            );
        }
				}
			}
		}
		
    }

    return (
        <>
		{needConfirmation?(<div>
			<p>{btn.bouton}</p>
						<input
					type="text"
					value={confirmation}
					onChange={(e) => setConfirmation(e.target.value)}
					placeholder="CONFIRMER"
					className={styles.confirmInput}
				/>
				<button type="button" onClick={handleDelete} disabled={confirmation !== "CONFIRMER"} className={iconStyles.btnInMain}><DeleteIcon /></button>
				<button type="button" onClick={() => setNeedConfirmation(false)} className={iconStyles.btnInMain}><CloseCancelIcon /></button>

						
						</div>):(<>
		<p>
                {btn.bouton}
				{btn.position>1&&<button
                    type="button"
                    onClick={() => setNeedConfirmation(true)}
                    className={clsx(styles.inline, iconStyles.btnInMain)}
                >
                    <DeleteIcon />
                </button>}
                
            </p>
		</>)}
            
        </>
    );
}
