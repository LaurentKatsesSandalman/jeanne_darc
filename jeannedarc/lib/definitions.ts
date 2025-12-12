import type { JSONContent } from '@tiptap/core';

export type ContenuTipTap = JSONContent;

export interface InterfacePage {
	id: string;
	url: string;
	content: ContenuTipTap;
	created_at?: string;
	updated_at?: string;
}

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