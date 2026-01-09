"use client";
import { ContenuBandeauBtnInterface, SectionInterface } from "@/lib/schemas";
// import styles from "./SectionBandeauBtn.module.css";
import { useState } from "react";
import { EditIcon } from "@/components/Icons/Icons";
import { usePathname } from "next/navigation";
import { ContenuBandeauBtnEdit } from "@/components/Contenus/ContenuBandeauBtn/ContenuBandeauBtnEdit";
import { ContenuBandeauBtn } from "@/components/Contenus/ContenuBandeauBtn/ContenuBandeauBtn";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css";

interface SectionBandeauBtnProps {
	section: SectionInterface;
	contenuBandeauBtn: ContenuBandeauBtnInterface;
	isAuth: boolean;
}

export function SectionBandeauBtnClient({
	section,
	contenuBandeauBtn,
	isAuth,
}: SectionBandeauBtnProps) {
	const [editBandeauBtn, setEditBandeauBtn] = useState(false);
	const url = usePathname();

	return (
		<div className="my-25">
			{isAuth ? (
				<>
							{editBandeauBtn ? (
								<ContenuBandeauBtnEdit
									contenu={contenuBandeauBtn}
									setEditBandeauBtn={setEditBandeauBtn}
								/>
							) : (
								<div>
									<ContenuBandeauBtn contenu={contenuBandeauBtn} />
									<button
										type="button"
										onClick={() => setEditBandeauBtn(true)}
										className={iconStyles.btnInMain}
									>
										<EditIcon />
									</button>
								</div>
							)}
					<DeleteSectionButton
						id_section={section.id_section}
						url={url}
					/>
				</>
			) : (
					<div >
						<ContenuBandeauBtn contenu={contenuBandeauBtn} />
					</div>
			)}
		</div>
	);
}
