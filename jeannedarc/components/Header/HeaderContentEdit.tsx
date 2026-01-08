import { updateContenuHeaderBtnAction } from "@/lib/actions/actionsContenu";
import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { CloseCancelIcon, SaveIcon } from "../Icons/Icons";
import styles from "./Header.module.css";
import iconStyles from "@/components/Icons/Icons.module.css";

interface HeaderContentEditProps {
    btn: ContenuHeaderBtnInterface;
    setIsEditing: Dispatch<SetStateAction<boolean>>;
}

export function HeaderContentEdit({
    btn,
    setIsEditing,
}: HeaderContentEditProps) {
    const [currentBtn, setCurrentBtn] = useState(btn);
	 const [error, setError] = useState("");

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        setCurrentBtn((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        if (currentBtn.bouton.length < 1) {
            setIsEditing(false);
            return;
        }
        const result = await updateContenuHeaderBtnAction(
            btn.id_contenu_headerbtn,
            { bouton: currentBtn.bouton }
        );
        if (!result.success) {
            console.error("Échec de la requête:", result);
            if ("errors" in result) {
                setError(
                    "Les données saisies ne sont pas valides. Veuillez vérifier vos champs."
                );
            } else if ("error" in result) {
                setError("Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.");
            }
            return;
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
            <input
                type="text"
                id={currentBtn.id_contenu_headerbtn}
                value={currentBtn.bouton}
                name="bouton"
                onChange={handleChange}
                className={styles.buttonEdit}
            />
            <div>
                <button
                    type="button"
                    onClick={() => setCurrentBtn(btn)}
                    className={iconStyles.btnInHeader}
                >
                    <CloseCancelIcon />
                </button>
                <button
                    type="button"
                    onClick={handleSave}
                    className={iconStyles.btnInHeader}
                >
                    <SaveIcon />
                </button>
				{error&&<p>{error}</p>}
            </div>
        </>
    );
}
