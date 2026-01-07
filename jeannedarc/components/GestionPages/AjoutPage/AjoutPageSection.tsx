"use client";

import { useMemo, useState } from "react";
// import { ContenuHeaderBtnInterface } from "@/lib/schemas";
import { SectionWithBtn } from "@/components/Header/HeaderServer";
import { SaveIcon } from "@/components/Icons/Icons";
import { createPageAction } from "@/lib/actions/actionsPage";
import { createContenuHeaderBtnAction } from "@/lib/actions/actionsContenu";
import iconStyles from "@/components/Icons/Icons.module.css"
import styles from "./AjoutPageSection.module.css"
import { getPageByUrl } from "@/lib/queries/contentCrudPage";

interface AjoutPageSectionProps {
    sections: SectionWithBtn[];
}

export function AjoutPageSection({ sections }: AjoutPageSectionProps) {
    // Error: Calling setState synchronously within an effect can trigger cascading renders
    /*const [infoSections, setInfoSections]=useState<InfoSection[]>([])
	useEffect(()=>{
		
		const tempInfoSections: InfoSection[]=[]
for (let i = 0; i < sections.length; i++) {
        tempInfoSections.push({
            key: sections[i][0].id_contenu_headerbtn,
            nom: sections[i][0].bouton,
            url: sections[i][0].lien_vers.replace("/", ""),
            longueur: sections[i].length,
            section_id: sections[i][0].id_section_fk,
        });
		
    }

setInfoSections(tempInfoSections)

	},[sections])*/

    const infoSections = useMemo(() => {
        return sections.map((section) => ({
            key: section[0].id_contenu_headerbtn,
            nom: section[0].bouton,
            url: section[0].lien_vers.replace("/", ""),
            longueur: section.length,
            section_id: section[0].id_section_fk,
        }));
    }, [sections]);

    const newForm = {
        racine_url: "default",
        main_url: "",
        //page
        // page_url:"",
        nom: "",
        //contenu_headerbtn
        id_section_fk: "",
        //id_page_fk: "",
        position: 99,
        // bouton: "",
        // lien_vers: "",
    };

    const [error, setError] = useState("");
    const [form, setForm] = useState(newForm);

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
    ) => {
		setError("")
        const { name, value } = e.target;
        setForm((prev) => {
            return { ...prev!, [name]: value };
        });
    };

    const handleChangeSelect = (e: React.ChangeEvent<HTMLSelectElement>) => {
        setError("")
		const { value } = e.target;
        const racine_url = infoSections.filter(
            (section) => section.section_id === value
        )[0].url;
        const id_section_fk = infoSections.filter(
            (section) => section.section_id === value
        )[0].section_id;
        const position =
            infoSections.filter((section) => section.section_id === value)[0]
                .longueur + 1;
        setForm((prev) => {
            return { ...prev!, racine_url, id_section_fk, position };
        });
    };

    const handleSave = async () => {
		if(form.racine_url==="default"){setError("Vous devez choisir une section"); return;}
		if(form.main_url.length<3){setError("L'URL doit faire au moins 3 caractères"); return;}
		if (!/^[a-z0-9-]+$/.test(form.main_url)){setError("L'URL ne peut contenir que des chiffres, des minuscules et des tirets, sans espaces"); return;}
		if(form.nom.length<2){setError("Le nom de la page doit faire au moins 2 caractères"); return;}
        // Calcule les valeurs DIRECTEMENT sans passer par setState
        const bouton = form.nom;
        const lien_vers = `/${form.racine_url}/${form.main_url}`;
        const page_url = `${form.racine_url}/${form.main_url}`;

		const existingPage = await getPageByUrl (page_url)
		if(existingPage){setError("Une page avec cette URL existe déjà"); return;}

        console.log("Valeurs calculées:", { page_url, nom: form.nom });

        const pagePayload = { page_url, nom: form.nom };
        const pageResult = await createPageAction(pagePayload);

        console.log("Page result:", pageResult);

        if (!pageResult.success) {
            throw new Error(
                "error" in pageResult ? pageResult.error : "Validation error"
            );
        }

        const btnPayload = {
            id_section_fk: form.id_section_fk,
            id_page_fk: pageResult.data.id_page,
            position: form.position,
            bouton,
            lien_vers,
        };

        const btnResult = await createContenuHeaderBtnAction(
            btnPayload,
            "/gestion-pages"
        );

        if (!btnResult.success) {
            throw new Error(
                "error" in btnResult ? btnResult.error : "Validation error"
            );
        }

        setForm(newForm);
		setError("")
    };

    return (
        <>
            <label htmlFor="section">Choix de la section</label>
            <select
                id="racine_url"
                name="racine_url"
                required
                onChange={handleChangeSelect}
                value={form.id_section_fk}
            >
                <option value="" disabled>
                    (section)
                </option>
                {infoSections.map((section) => (
                    <option key={section.key} value={section.section_id}>
                        {section.nom}
                    </option>
                ))}
            </select>

            <label htmlFor="main_url">Url (sans préfixe)</label>
            <input
                type="text"
                id="main_url"
                name="main_url"
                value={form.main_url}
                onChange={handleChange}
				required
            />
            <label htmlFor="nom">Nom de la page</label>
            <input
                type="text"
                id="nom"
                name="nom"
                value={form.nom}
                onChange={handleChange}
            />
			{error&&(<p className={styles.error}>{error}</p>)}
            <button type="button" onClick={handleSave} className={iconStyles.btnInMain}>
                <SaveIcon  />
            </button>
			
            
        </>
    );
}
