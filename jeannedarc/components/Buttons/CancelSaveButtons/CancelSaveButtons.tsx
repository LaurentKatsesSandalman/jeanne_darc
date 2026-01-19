import { CloseCancelIcon, SaveIcon } from "@/components/Icons/Icons";
import { Dispatch, SetStateAction } from "react";
import styles from "./CancelSaveButtons.module.css"
import iconStyles from "@/components/Icons/Icons.module.css";
import clsx from "clsx";

interface CancelSaveButtonsProps {
setEdit: Dispatch<SetStateAction<boolean>>;
handleSave: () => void | Promise<void>;
error?: string;
additionalClassName?: string; 
}

export function CancelSaveButtons ({setEdit, handleSave, error, additionalClassName}:CancelSaveButtonsProps) {

	return (<div className={clsx("flex justify-center", additionalClassName) } // clsx ignore automatiquement les valeurs undefined, null, false, ou "", donc pas besoin de condition
	> 
                <button
                    type="button"
                    onClick={() => setEdit(false)}
                    className={clsx(iconStyles.btnInMain, iconStyles.left) } 
                >
                    <CloseCancelIcon />
                </button>
                <button
                    type="button"
                    onClick={handleSave}
                    className={clsx(iconStyles.btnInMain, iconStyles.right) }
                >
                    <SaveIcon />
                </button>
                {error && <p className={styles.error}>{error}</p>}
            </div>)
}