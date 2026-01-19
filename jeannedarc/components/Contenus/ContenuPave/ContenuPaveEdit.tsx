import { PaveBlocInterface, UpdatePaveBloc } from "@/lib/schemas";
import { Dispatch, SetStateAction, useState } from "react";
import { usePathname } from "next/navigation";
import { updatePaveBlocAction } from "@/lib/actions/actionsContenu";
import styles from "./ContenuPave.module.css"
import { IconSelector } from "@/components/utils/IconSelector/IconSelector";
import { CancelSaveButtons } from "@/components/Buttons/CancelSaveButtons/CancelSaveButtons";

interface ContenuPaveEditProps {
	contenu: PaveBlocInterface;
	setEditPave: Dispatch<SetStateAction<boolean>>;
}

export function ContenuPaveEdit ( {contenu, setEditPave}:ContenuPaveEditProps ) {

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
		
		if (currentContent.soustitre.length < 1) {
			setError("Le bloc doit avoir un titre");
			return;
		}
		
		const notUpdateKeys = [
			"id_pave_bloc",
			"id_contenu_pave_fk",
			"created_at",
			"updated_at",
			"icone"
		] as const; //le type de la constante n'est plus string mais un littéral qui est un tableau avec ces 4 valeurs

		type NotUpdatedKeys = (typeof notUpdateKeys)[number]; //number = quel que soit l'index ; ce type transform le tableau littéral en une collection de 4 littéraux
		type UpdateKeys = Exclude<keyof typeof contenu, NotUpdatedKeys>;

		const payload: UpdatePaveBloc = {};
		if(currentContent.icone!==currentIcon){payload.icone=currentIcon; setCurrentContent((prev)=>{
			return {...prev, icone: currentIcon}
		} )}

		(Object.keys(contenu) as Array<keyof typeof contenu>).forEach((key) => {
			if (!notUpdateKeys.includes(key as NotUpdatedKeys)) {
				const updateKey = key as UpdateKeys;
				if (contenu[updateKey] !== currentContent[updateKey]) {
					payload[updateKey] = currentContent[
						updateKey
					] as UpdatePaveBloc[UpdateKeys];
				}
			}
		});

		if (Object.keys(payload).length === 0) {
			setEditPave(false);
			return;
		}

		const result = await updatePaveBlocAction(
			contenu.id_pave_bloc,
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
		setEditPave(false);
	}

return (
        <>
            <label htmlFor="soustitre" className={styles.label}>
                Titre du bloc
            </label>
            <input
                type="text"
                id="soustitre"
                name="soustitre"
                value={currentContent.soustitre}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<label htmlFor="lien_vers" className={styles.label}>
              <p>  Page ciblée (optionnel) ; ne pas mettre le nom de domaine </p>
				<p>(par exemple /projets/projet-pedagogique pour https://www.jeannedarc33.fr/projets/projet-pedagogique )</p>
            </label>
            <input
                type="text"
                id="lien_vers"
                name="lien_vers"
                value={currentContent.lien_vers}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<label htmlFor="description1" className={styles.label}>
                Description (optionnel) ; tout écrire dans le 1er champ si possible, changer de champ pour sauter une ligne.
            </label>
            <textarea
                rows={3}
				cols={50}
                id="description1"
                name="description1"
                value={currentContent.description1}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			 <input
                type="text"
                id="description2"
                name="description2"
                value={currentContent.description2}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<input
                type="text"
                id="description3"
                name="description3"
                value={currentContent.description3}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<input
                type="text"
                id="description4"
                name="description4"
                value={currentContent.description4}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<input
                type="text"
                id="description5"
                name="description5"
                value={currentContent.description5}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<input
                type="text"
                id="description6"
                name="description6"
                value={currentContent.description6}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<input
                type="text"
                id="description7"
                name="description7"
                value={currentContent.description7}
                onChange={handleChange}
				className={styles.smallBorder}
            />
			<p  className={styles.label}>
                Icône (optionnel)
            </p>
            <IconSelector currentIcon={currentIcon} setCurrentIcon={setCurrentIcon} additionalClassName={""} />
			<CancelSaveButtons setEdit={setEditPave} handleSave={handleSave} error={error} additionalClassName={""}/>
        </>
    );


}