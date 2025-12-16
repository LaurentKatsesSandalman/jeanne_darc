import { CloseCancelIcon, SaveIcon } from "@/components/Icons/Icons";
import { ContenuTitreInterface, UpdateContenuTitre } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import styles from "./ContenuTitre.module.css";
import { updateContenuTitreAction } from "@/lib/actions/actionsContenu";

interface ContenuTitreEditProps {
    contenu: ContenuTitreInterface;
    // isAuth: boolean;
    setEditTitre: Dispatch<SetStateAction<boolean>>;
}

export function ContenuTitreEdit({
    contenu,
    /*isAuth,*/ setEditTitre,
}: ContenuTitreEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
    const url = usePathname();

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        setCurrentContent((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    async function handleSave() {
        const payload: UpdateContenuTitre = {};
        if (contenu.titre1 !== currentContent.titre1) {
            payload.titre1 = currentContent.titre1;
        }
        if (contenu.titre2 !== currentContent.titre2) {
            payload.titre2 = currentContent.titre2;
        }
        if (contenu.description !== currentContent.description) {
            payload.description = currentContent.description;
        }
        if (Object.keys(payload).length === 0) {
            setEditTitre(false);
            return;
        }

        const result = await updateContenuTitreAction(
            contenu.id_contenu_titre,
            payload,
            url
        );

        // if ("error" in result) { // comme result.error peut ne pas exister, on ne peut pas faire if(result.error)
        //     throw new Error(result.error);
        // }

        if (!result.success) {
            throw new Error("error" in result ? result.error : "Validation error");
        }

        const updatedContenu = result.data;
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditTitre(false);
    }

    return (
        <>
            <label htmlFor="titre1" className={styles.label}>
                Titre1 (petit)
            </label>
            <input
                type="text"
                id="titre1"
                name="titre1"
                value={currentContent.titre1}
                onChange={handleChange}
                className={styles.h1Edit}
            />
            <label htmlFor="titre2" className={styles.label}>
                Titre2 (plus grand, optionnel)
            </label>
            <input
                type="text"
                id="titre2"
                name="titre2"
                value={currentContent.titre2}
                onChange={handleChange}
                className={styles.h2Edit}
            />
            <label htmlFor="description" className={styles.label}>
                Description (optionnel)
            </label>
            <input
                type="text"
                id="description"
                name="description"
                value={currentContent.description}
                onChange={handleChange}
                className={styles.description}
            />
            {/* il faudra faire de tous ces boutons un composant */}
            <div>
                <button type="button" onClick={() => setEditTitre(false)}>
                    <CloseCancelIcon />
                </button>
                <button type="button" onClick={handleSave}>
                    <SaveIcon />
                </button>
            </div>
        </>
    );
}
