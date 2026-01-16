import { useState, Dispatch, SetStateAction } from "react";

import styles from "./Recherche.module.css";
import { CloseCancelIcon, SearchIcon } from "../Icons/Icons";
import { useRouter } from "next/navigation";

interface RechercheModalProps {
	setModalActive: Dispatch<SetStateAction<boolean>>;
}

export function RechercheModal({ setModalActive }:RechercheModalProps) {
    const [recherche, setRecherche] = useState("");
    const [error, setError] = useState("");
    const router = useRouter();

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setError("");
        setRecherche(e.target.value);
    };

    const handleSearch = (e: React.FormEvent) => {
        e.preventDefault();
		if (recherche.length<3){setError("La recherche doit comporter au moins trois caractères"); return;}
		router.push(`/recherche?q=${encodeURIComponent(recherche)}`); // remplace les espaces par %20 et autres modifs
		setModalActive(false)
    };

    return (
        <div className={styles.rechercheModalContainer}>
			<button onClick={()=>setModalActive(false)} className={styles.rechercheModalClose}><CloseCancelIcon/></button>
            <form onSubmit={handleSearch} className={styles.rechercheModalForm}>
                <input
                    type="text"
                    className={styles.rechercheModalInput}
                    value={recherche}
                    onChange={handleChange}
                    id="recherche"
					placeholder="Rechercher"
                ></input>
                <button type="submit">
                    <SearchIcon className={styles.rechercheModalIcon} />
                </button>
            </form>
            {error && <p className={styles.error}>{error}</p>}
        </div>
    );
}
