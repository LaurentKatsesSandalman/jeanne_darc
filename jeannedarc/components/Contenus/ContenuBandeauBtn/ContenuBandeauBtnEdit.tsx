import { updateContenuBandeauBtnAction } from "@/lib/actions/actionsContenu";
import {
    ContenuBandeauBtnInterface,
    UpdateContenuBandeauBtn,
} from "@/lib/schemas";
import { usePathname } from "next/navigation";
import { Dispatch, SetStateAction, useState } from "react";
import styles from "./ContenuBandeauBtn.module.css";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";
import { IconSelector } from "@/components/utils/IconSelector/IconSelector";

interface ContenuBandeauBtnEditProps {
    contenu: ContenuBandeauBtnInterface;
    setEditBandeauBtn: Dispatch<SetStateAction<boolean>>;
}

export function ContenuBandeauBtnEdit({
    contenu,
    setEditBandeauBtn,
}: ContenuBandeauBtnEditProps) {
    const [currentContent, setCurrentContent] = useState(contenu);
	const [currentIcon, setCurrentIcon]= useState(contenu.icone) // à mettre dans chaque parent qui utilise iconselector
    const [error, setError] = useState("");
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
		
        if (currentContent.bouton.length < 1) {
            setError("Le nom du bouton ne peut pas être vide");
            return;
        }
        if (currentContent.lien_vers.length < 3) {
            setError("L'URL du bouton ne peut pas être aussi courte");
            return;
        }

        const notUpdateKeys = [
            "id_contenu_bandeaubtn",
            "id_section_fk",
            "created_at",
            "updated_at",
			"icone"
        ] as const; //le type de la constante n'est plus string mais un littéral qui est un tableau avec ces 4 valeurs

        type NotUpdatedKeys = (typeof notUpdateKeys)[number]; //number = quel que soit l'index ; ce type transform le tableau littéral en une collection de 4 littéraux
        type UpdateKeys = Exclude<keyof typeof contenu, NotUpdatedKeys>;

        const payload: UpdateContenuBandeauBtn = {};
		if(currentContent.icone!==currentIcon){payload.icone=currentIcon; setCurrentContent((prev)=>{
			return {...prev, icone: currentIcon}
		} )}

        (Object.keys(contenu) as Array<keyof typeof contenu>).forEach((key) => {
            if (!notUpdateKeys.includes(key as NotUpdatedKeys)) {
                const updateKey = key as UpdateKeys;
                if (contenu[updateKey] !== currentContent[updateKey]) {
                    payload[updateKey] = currentContent[
                        updateKey
                    ] as UpdateContenuBandeauBtn[UpdateKeys];
                }
            }
        });

        if (Object.keys(payload).length === 0) {
            setEditBandeauBtn(false);
            return;
        }

        const result = await updateContenuBandeauBtnAction(
            contenu.id_contenu_bandeaubtn,
            payload,
            url
        );

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

        const updatedContenu = result.data;
        if (updatedContenu) {
            setCurrentContent(updatedContenu);
        }
        setEditBandeauBtn(false);
    }

    return (
        <>
            <label htmlFor="bouton" className={styles.label}>
                Nom du bouton
            </label>
            <input
                type="text"
                id="bouton"
                name="bouton"
                value={currentContent.bouton}
                onChange={handleChange}
            />
			<label htmlFor="lien_vers" className={styles.label}>
              <p>  Url du bouton. Si c&#39;est un lien interne, ne pas mettre le nom de domaine </p>
				<p>(par exemple /projets/projet-pedagogique pour https://www.jeannedarc33.fr/projets/projet-pedagogique )</p>
            </label>
            <input
                type="text"
                id="lien_vers"
                name="lien_vers"
                value={currentContent.lien_vers}
                onChange={handleChange}
            />
			<label htmlFor="titre" className={styles.label}>
                Titre (optionnel)
            </label>
            <input
                type="text"
                id="titre"
                name="titre"
                value={currentContent.titre}
                onChange={handleChange}
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
            />
			<p  className={styles.label}>
                Icône (optionnel)
            </p>
            <IconSelector currentIcon={currentIcon} setCurrentIcon={setCurrentIcon} additionalClassName={""} />
			<CancelSaveButtons setEdit={setEditBandeauBtn} handleSave={handleSave} error={error} additionalClassName={""}/>
        </>
    );
}
