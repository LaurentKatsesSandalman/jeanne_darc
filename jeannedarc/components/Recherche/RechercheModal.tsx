import { useState, Dispatch, SetStateAction } from "react";
import { FocusTrap } from "focus-trap-react";
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
		<FocusTrap focusTrapOptions={{
        escapeDeactivates: true,  // Échap désactive le trap
        clickOutsideDeactivates: true,  // Clic dehors désactive le trap
    }}>
        <div className={styles.rechercheModalContainer} onClick={()=>setModalActive(false)}>
			<button onClick={()=>setModalActive(false)} className={styles.rechercheModalClose} aria-label="Fermer la recherche"><CloseCancelIcon/></button>
            <form onSubmit={handleSearch} className={styles.rechercheModalForm} onClick={(e) => e.stopPropagation()}> {/* empêche la popup de se fermer au clic */}
                <input
                    autoFocus
					type="text"
                    className={styles.rechercheModalInput}
                    value={recherche}
                    onChange={handleChange}
                    id="recherche"
					placeholder="Rechercher"
                ></input>
                <button type="submit" aria-label="Rechercher sur le site" className={styles.rechercheModalBtn}>
                    <SearchIcon className={styles.rechercheModalIcon} />
                </button>
            </form>
            {error && <p role="alert" className={styles.error}>{error}</p>}
        </div></FocusTrap>
    );
}
