"use client";
import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { DeleteIcon } from "../../Icons/Icons";

import styles from "./SupprPages.module.css";

import { deletePageAction } from "@/lib/actions/actionsPage";
import { usePathname } from "next/navigation";

interface SupprPagesContentEditProps {
    btn: ContenuHeaderBtnInterface;
}

export function SupprPagesContentEdit({ btn }: SupprPagesContentEditProps) {
    const url = usePathname();

    async function handleDelete() {
        const deletePageResult = await deletePageAction(btn.id_page_fk, url);

        if (!deletePageResult.success) {
            throw new Error(
                "error" in deletePageResult
                    ? deletePageResult.error
                    : "Validation error"
            );
        }
    }

    return (
        <>
            <p>
                {btn.bouton}
                <button
                    type="button"
                    onClick={handleDelete}
                    className={styles.inline}
                >
                    <DeleteIcon />
                </button>
            </p>
        </>
    );
}
