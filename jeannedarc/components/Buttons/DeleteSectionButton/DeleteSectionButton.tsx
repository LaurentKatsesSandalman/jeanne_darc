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

    async function handleDelete() {
        const result = await deleteSectionAction(id_section, url);

        if (!result.success) {
            throw new Error(
                "error" in result ? result.error : "Validation error"
            );
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
