"use client";
import { ContenuSoloBtnInterface } from "@/lib/schemas";
// import styles from "./SectionSoloBtn.module.css";
import { useState } from "react";
import { EditIcon } from "@/components/Icons/Icons";
import { usePathname } from "next/navigation";
import { ContenuSoloBtnEdit } from "@/components/Contenus/ContenuSoloBtn/ContenuSoloBtnEdit";
import { ContenuSoloBtn } from "@/components/Contenus/ContenuSoloBtn/ContenuSoloBtn";
import iconStyles from "@/components/Icons/Icons.module.css";
import { DeleteBtnButton } from "@/components/Buttons/DeleteSectionButton/DeleteBtnButton";

interface SectionSoloBtnProps {
	contenuSoloBtn: ContenuSoloBtnInterface;
	isAuth: boolean;
}

export function SectionSoloBtnClient({
	contenuSoloBtn,
	isAuth,
}: SectionSoloBtnProps) {
	const [editSoloBtn, setEditSoloBtn] = useState(false);
	const url = usePathname();

	return (
		<>
			{isAuth ? (
				<>
							{editSoloBtn ? (
								<ContenuSoloBtnEdit
									contenu={contenuSoloBtn}
									setEditSoloBtn={setEditSoloBtn}
								/>
							) : (
								<div>
									<ContenuSoloBtn contenu={contenuSoloBtn} />
									<button
										type="button"
										onClick={() => setEditSoloBtn(true)}
										className={iconStyles.btnInMain}
									>
										<EditIcon />
									</button>
								</div>
							)}
					<DeleteBtnButton
						id_button={contenuSoloBtn.id_contenu_solobtn}
						url={url}
					/>
				</>
			) : (
					<div >
						<ContenuSoloBtn contenu={contenuSoloBtn} />
					</div>
			)}
		</>
	);
}
