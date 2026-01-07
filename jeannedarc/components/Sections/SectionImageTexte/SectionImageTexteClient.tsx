"use client";
import clsx from "clsx";
import { ContenuImageInterface, ContenuTexteInterface, SectionInterface, UpdateSection } from "@/lib/schemas";
// import styles from "./SectionImageTexte.module.css";
import { useState } from "react";
import { ContenuTexteEdit } from "@/components/tiptap/tiptap-templates/simple/simple-editor";
import { ContenuTexte } from "@/components/Contenus/ContenuTexte/ContenuTexte";
import { EditIcon, SwitchIcon } from "@/components/Icons/Icons";
import { updateSectionAction } from "@/lib/actions/actionsSection";
import { usePathname } from "next/navigation";
import { ContenuImageEdit } from "@/components/Contenus/ContenuImage/ContenuImageEdit";
import { ContenuImage } from "@/components/Contenus/ContenuImage/ContenuImage";
import { DeleteSectionButton } from "@/components/Buttons/DeleteSectionButton/DeleteSectionButton";
import iconStyles from "@/components/Icons/Icons.module.css"

interface SectionImageTexteProps {
    section: SectionInterface;
	contenuTexte: ContenuTexteInterface;
	contenuImage: ContenuImageInterface;
    isAuth: boolean;
}

export function SectionImageTexteClient({ section, contenuTexte, contenuImage, isAuth }: SectionImageTexteProps) {
    const [editTexte, setEditTexte] = useState(false);
	const [editImage, setEditImage] = useState(false);

	const url = usePathname();

	async function handleSwitchSave(){
		const payload:UpdateSection = {revert:!section.revert}
		const result = await updateSectionAction (section.id_section, payload, url)

				if (!result.success) {
            throw new Error("error" in result ? result.error : "Validation error");
        }
	}

    return (
        <>
            {isAuth ? (
                <>
				<div className={clsx(
    "flex",
    section.revert
      ? "flex-col-reverse sm:flex-row-reverse"
      : "flex-col sm:flex-row"
  )}>
                   <div className="w-full sm:w-1/2"> {editImage ? (
                        <ContenuImageEdit
                            contenu={contenuImage}
                            // isAuth={isAuth}
                            setEditImage={setEditImage}
                        />
                    ) : (
                        <div>
                            <ContenuImage contenu={contenuImage} />
                            <button
                                type="button"
                                onClick={() => setEditImage(true)}
								className={iconStyles.btnInMain}
                            >
                                <EditIcon />
                            </button>
                        </div>
                    )}
					</div>
					<div className="w-full sm:w-1/2">
					{editTexte ? (
                        <ContenuTexteEdit
                            contenu={contenuTexte}
                            // isAuth={isAuth}
                            setEditTexte={setEditTexte}
                        />
                    ) : (
                        <div>
                            <ContenuTexte contenu={contenuTexte} />
                            <button
                                type="button"
                                onClick={() => setEditTexte(true)}
								className={iconStyles.btnInMain}
                            >
                                <EditIcon />
                            </button>
                        </div>
                    )}
					</div>
					</div>
                    
					<DeleteSectionButton id_section={section.id_section} url={url}/>
					<button
                                type="button"
                                onClick={handleSwitchSave}
								className={iconStyles.btnInMain}
                            >
                                <SwitchIcon />
                            </button>
                </>
            ) : (
                <div className={clsx(
    "flex",
    section.revert
      ? "flex-col-reverse sm:flex-row-reverse"
      : "flex-col sm:flex-row"
  )}>
				<div className="w-full sm:w-1/2"><ContenuImage contenu={contenuImage} /></div>
                    
					<div className="w-full sm:w-1/2"><ContenuTexte contenu={contenuTexte} /></div>
                </div>
            )}
        </>
    );
}
