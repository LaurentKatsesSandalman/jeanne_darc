"use client";
import { ContenuTitreInterface } from "@/lib/definitions";
import styles from "./ContenuTitre.module.css";
import { useState } from "react";

interface ContenuTitreProps {
    contenu: ContenuTitreInterface;
    isAuth: boolean;
}

export function ContenuTitre({ contenu, isAuth }: ContenuTitreProps) {
    const [editMode, setEditMode] = useState(false);
	const [currentContent, setCurrentContent] = useState(contenu)

	const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
		const { name, value } = e.target;
		setCurrentContent((prev) => {
			return { ...prev!, [name]: value };
		});
	};

    return (
        <>
            {editMode ? (
                <>
                    <label htmlFor="titre1">Titre1 (petit)</label>
					<input type="text" id="titre1" name="titre1" value={currentContent.titre1} onChange={handleChange}/>
					<label htmlFor="titre2">Titre2 (plus grand, optionnel)</label>
					<input type="text" id="titre2" name="titre2" value={currentContent.titre2} onChange={handleChange}/>
					<label htmlFor="description">Description (optionnel)</label>
					<input type="text" id="description" name="description" value={currentContent.description} onChange={handleChange}/>
					{/* il faudra faire de tous ces boutons un composant */}
					<div>
						<button type="button" onClick={()=>setEditMode(false)}>CancelIcone</button>
						<button type="button" onClick={handleSave}>SaveIcone</button>
						<button type="button" onClick={handleDelete}>DeleteIcone</button>
					</div>
                </>
            ) : (
                <>
                    {contenu.titre1&&<h1>{contenu.titre1}</h1>}
                   {contenu.titre2&&<h2>{contenu.titre2}</h2>}
                    {contenu.description&&<p>{contenu.description}</p>}
                    {isAuth && <button type="button" onClick={()=>setEditMode(true)}>EditIcone</button>}
                </>
            )}
        </>
    );
}
