"use client";
// import clsx from "clsx";
import { PaveBlocInterface } from "@/lib/schemas";
// import styles from "./SectionPaves.module.css";
import { useState } from "react";
import { ContenuPaveEdit } from "@/components/Contenus/ContenuPave/ContenuPaveEdit";
import { ContenuPave } from "@/components/Contenus/ContenuPave/ContenuPave";
import { EditIcon } from "@/components/Icons/Icons";
import iconStyles from "@/components/Icons/Icons.module.css";
import { DeletePaveButton } from "@/components/Buttons/DeleteSectionButton/DeletePaveButton";
import { usePathname } from "next/navigation";
import styles from "./SectionPaves.module.css"

interface SectionPavesProps {
    paveBloc:PaveBlocInterface;
    isAuth: boolean;
}

export function SectionPaveClient({
    paveBloc,
    isAuth,
}: SectionPavesProps) {
    const [editPave, setEditPave] = useState(false);
	const url = usePathname()

    return (
        <>
            <div className={styles.blocSize}>
                {editPave ? (
                    <ContenuPaveEdit
                        contenu={paveBloc}
                        
                        setEditPave={setEditPave}
                    />
                ) : (
                    <div>
                        <ContenuPave contenu={paveBloc} />
                        {isAuth && (
                            <button
                                type="button"
                                onClick={() => setEditPave(true)}
                                className={iconStyles.btnInMain}
                            >
                                <EditIcon />
                            </button>
                        )}
                    </div>
                )}
				{isAuth && <DeletePaveButton id_pave={paveBloc.id_pave_bloc} url={url} />}
            </div>
        </>
    );
}
