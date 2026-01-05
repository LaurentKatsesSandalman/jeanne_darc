import { updateContenuHeaderBtnAction } from "@/lib/actions/actionsContenu";
import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react"
import { CloseCancelIcon, SaveIcon } from "../Icons/Icons";
import styles from "./Header.module.css";

interface HeaderContentEditProps {
	btn: ContenuHeaderBtnInterface ;
	setIsEditing: Dispatch<SetStateAction<boolean>>;
}


export function HeaderContentEdit ({btn, setIsEditing}: HeaderContentEditProps ) {
	const [currentBtn, setCurrentBtn] = useState (btn)

	const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        setCurrentBtn((prev) => {
            return { ...prev!, [name]: value };
        });
    };

	async function handleSave () {
		const result = await updateContenuHeaderBtnAction (btn.id_contenu_headerbtn,{bouton : currentBtn.bouton})
		if (!result.success) {
			setIsEditing(false)
							throw new Error("error" in result ? result.error : "Validation error");
		}
					const updatedContenu = result.data;
			// à vérifier mais je pense que c'est complétement inutile puisque refresh path + le composant est démonté car edit passe à false
			if (updatedContenu) {
				setCurrentBtn(updatedContenu);
			}
			setIsEditing(false);
	}

	return (
		<>
		<input type="text" id={currentBtn.id_contenu_headerbtn}  value={currentBtn.bouton} name="bouton" onChange={handleChange} className={styles.buttonEdit} />
		<div>
						<button type="button" onClick={() => setCurrentBtn(btn)}>
							<CloseCancelIcon />
						</button>
						<button type="button" onClick={handleSave}>
							<SaveIcon />
						</button>
					</div>
		</>
	)
}