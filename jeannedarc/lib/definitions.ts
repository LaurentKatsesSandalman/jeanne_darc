import type { JSONContent } from '@tiptap/core';

export type ContenuTipTap = JSONContent;

export interface UtilisateurInterface {
    id_utilisateur: string;
    email: string;
    name: string;
    password: string;
    is_admin: boolean;
    created_at?: string;
	updated_at?: string;
};

export interface PageInterface {
	id_page: string;
	page_url: string;
	nom?: string;
	created_at?: string;
	updated_at?: string;
}

export interface sectionInterface {
    id_section: string;
    id_page_fk: string;
    position: number;
    type: string;
    revert: boolean;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_imageInterface {
    id_contenu_image: string;
    id_section_fk: string;
    image_url: string;
    lien_vers?: string;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_texteInterface {
    id_contenu_texte: string;
    id_section_fk: string;
    tiptap_content: ContenuTipTap;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_contactInterface {
    id_contenu_contact: string;
    id_section_fk: string;
    titre: string;
    champ1: string;
    champ2: string;
    champ3: string;
    champ4: string;
    bouton: string;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_pdfInterface {
    id_contenu_pdf: string;
    id_section_fk: string;
    pdf_url: string;
    created_at?: string;
	updated_at?: string;
};

export interface ContenuTitreInterface {
	id_contenu_titre: string;
    id_section_fk: string;
    is_mega: boolean;
    titre1?:string;
    titre2?:string;
    description?:string;
    created_at?: string;
	updated_at?: string;
}

export interface contenu_paveInterface {
    id_contenu_pave: string;
    id_section_fk: string;
    titre?: string;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_bandeaubtnInterface {
    id_contenu_bandeaubtn: string;
    id_section_fk: string;
    icone_url?: string;
    titre?: string;
    description?: string;
    bouton: string;
    lien_vers: string;
    created_at?: string;
	updated_at?: string;
};

export interface contenu_headerbtnInterface {
    id_contenu_headerbtn: string;
    id_section_fk: string;
    position: number;
    bouton: string;
    lien_vers: string;
    created_at?: string;
	updated_at?: string;
};

export interface pave_blocInterface {
    id_pave_bloc: string;
    id_contenu_pave_fk: string;
    position: number;
    icone_url?: string;
    soustitre?: string;
    description?: string;
    lien_vers?: string;
    created_at?: string;
	updated_at?: string;
};