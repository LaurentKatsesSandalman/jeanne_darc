import { deleteSectionAction } from "@/lib/actions/actionsSection";
import styles from "./DeleteSectionButton.module.css";
import iconStyles from "@/components/Icons/Icons.module.css";
import { useState } from "react";
import { CloseCancelIcon, DeleteIcon } from "@/components/Icons/Icons";
import { SectionInterface } from "@/lib/schemas";
import clsx from "clsx";

interface DeleteSectionButtonProps {
    id_section: SectionInterface["id_section"];
    url: string;
}

export function DeleteSectionButton({
    id_section,
    url,
}: DeleteSectionButtonProps) {
    const [needConfirmation, setNeedConfirmation] = useState(false);
    const [confirmation, setConfirmation] = useState<string>("");
    const [error, setError] = useState("");

    async function handleDelete() {
        const result = await deleteSectionAction(id_section, url);

        if (!result.success) {
            console.error("Échec de la requête:", result);
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
    }

    return (
        <>
            {needConfirmation ? (
                <div className="flex w-[min(90%,300px)] mx-auto">
                    <input
                        type="text"
                        value={confirmation}
                        onChange={(e) => setConfirmation(e.target.value)}
                        placeholder="CONFIRMER"
                        className={styles.confirmInput}
                    />
                    <button
                        type="button"
                        onClick={handleDelete}
                        disabled={confirmation !== "CONFIRMER"}
                        className={iconStyles.btnInMain}
                    >
                        <DeleteIcon />
                    </button>
                    <button
                        type="button"
                        onClick={() => setNeedConfirmation(false)}
                        className={iconStyles.btnInMain}
                    >
                        <CloseCancelIcon />
                    </button>
                    {error && <p className={styles.error}>{error}</p>}
                </div>
            ) : (
                <div>
                    <button
                        className={clsx(styles.deleteBtn, iconStyles.btnInMain)}
                        type="button"
                        onClick={() => setNeedConfirmation(true)}
                    >
                        <DeleteIcon />
                    </button>
                </div>
            )}
        </>
    );
}
