import { ContenuContactInterface } from "@/lib/schemas";
import styles from "./ContenuContact.module.css";
import { useState } from "react";

interface ContenuContactProps {
    contenu: ContenuContactInterface;
}

export function ContenuContact({ contenu }: ContenuContactProps) {
    const [message, setMessage] = useState("");
    const [error, setError] = useState("");
    const emptyForm = {
        id_form: contenu.id_contenu_contact,
        champ1: contenu.champ1,
        champ2: contenu.champ2,
        champ3: contenu.champ3,
        champ4: contenu.champ4,
        input1: "",
        input2: "",
        input3: "",
        input4: "",
    };

    const [formData, setFormData] = useState(emptyForm);

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
    ) => {
        setMessage("");
        setError("");
        const { name, value } = e.target;
        setFormData((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setMessage("");
        setError("");
        if (
            !formData.input1 ||
            !formData.input2 ||
            !formData.input3 ||
            !formData.input4
        ) {
            setError("Tous les champs doivent être remplis");
            return;
        }
        const regexNomPrenom = /^(?=.*[a-zà-ÿ])(?=.{5,})[a-zA-ZÀ-ÿ\s'-]+$/;
        if (!regexNomPrenom.test(formData.input1)) {
            setError("Le premier champ doit contenir un nom et un prénom");
            return;
        }

        const regexTel10 = /^(?:\d\s*){10}$/;
        const regexTel11 = /^(?=(?:[^0-9]*[0-9]){11}[^0-9]*$)[+\d\s()]+$/; //(?=(?:[^0-9]*[0-9]){11}[^0-9]*$) : lookahead qui vérifie exactement 11 chiffres
        // [+\d\s()]+ : autorise chiffres, espaces, +, ( et )

        if (
            !regexTel10.test(formData.input2) &&
            !regexTel11.test(formData.input2)
        ) {
            setError(
                "Le deuxième champ attend un numéro de téléphone dans l'un des formats habituels",
            );
            return;
        }

		const regexEmailRFC5322 = /^[\w.!#$%&'*+/=?^`{|}~-]+@[a-z\d](?:[a-z\d-]{0,61}[a-z\d])?(?:\.[a-z\d](?:[a-z\d-]{0,61}[a-z\d])?)*$/i;
		
		if (!regexEmailRFC5322.test(formData.input3)) {
            setError("Le troisième champ attend une adresse email valide");
            return;
        }

        const payload = JSON.stringify({ form: formData });
        const res = await fetch("api/sendemail", {
            method: "POST",
            headers: {
                //headers au pluriel !!!
                "Content-Type": "application/json",
            },
            body: payload,
        });
        if (!res.ok) {
            setError(
                "Une erreur est survenue lors de l'envoi. Veuillez réessayer.",
            );
            return;
        } else {
            setMessage("Message envoyé");
            setFormData(emptyForm);
        }
    };

    return (
        <>
            <h2 className={styles.h2}>{contenu.titre}</h2>
            <form onSubmit={handleSubmit} noValidate>
                <label htmlFor="input1" className={styles.label}>
                    {contenu.champ1}
                    <span className={styles.required}> *</span>
                </label>
                <input
                    // nom et prenom par defaut
                    type="text"
                    id="input1"
                    name="input1"
                    value={formData.input1}
                    onChange={handleChange}
                    className={styles.smallBorder}
                />
                <label htmlFor="input2" className={styles.label}>
                    {contenu.champ2}
                    <span className={styles.required}> *</span>
                </label>
                <input
                    //tel
                    type="tel"
                    id="input2"
                    name="input2"
                    value={formData.input2}
                    onChange={handleChange}
                    className={styles.smallBorder}
                />
                <label htmlFor="input3" className={styles.label}>
                    {contenu.champ3}
                    <span className={styles.required}> *</span>
                </label>
                <input
                    //email
                    type="email"
                    id="input3"
                    name="input3"
                    value={formData.input3}
                    onChange={handleChange}
                    className={styles.smallBorder}
                />
                <label htmlFor="input4" className={styles.label}>
                    {contenu.champ4}
                    <span className={styles.required}> *</span>
                </label>
                <textarea
                    rows={5}
                    // cols={50}
                    id="input4"
                    name="input4"
                    value={formData.input4}
                    onChange={handleChange}
                    className={styles.smallBorderTextArea}
                />
                <input
                    type="submit"
                    value={contenu.bouton}
                    className={styles.submitBtn}
                />
                {message && (
                    <p aria-live="polite" className={styles.message}>
                        {message}
                    </p>
                )}
                {error && (
                    <p role="alert" className={styles.error}>
                        {error}
                    </p>
                )}
            </form>
        </>
    );
}
