"use server";

import { sql } from "../db";
import { getPageByUrl } from "./contentCrudPage";

type TableNames =
    | "page"
    | "section"
    | "contenu_image"
    | "contenu_texte"
    | "contenu_contact"
    | "contenu_pdf"
    | "contenu_titre"
    | "contenu_pave"
    | "contenu_bandeaubtn"
    | "contenu_solobtn"
    | "contenu_headerbtn"
    | "pave_bloc";

interface CreateIndexInterface {
    
    ref_id: string;
    ref_table: TableNames;
    content_plaintext: string;
}

export async function createIndex({
    
    ref_table,
    ref_id,
    content_plaintext,
}: CreateIndexInterface, url:string) {
	const page = await getPageByUrl(url)

	if(!page){return;}

    const data = { id_page_fk:page.id_page, ref_table, ref_id, content_plaintext };

    await sql`
	INSERT INTO text_index ${sql(data)}
	ON CONFLICT (ref_id)
	DO UPDATE 
	SET content_plaintext = EXCLUDED.content_plaintext,
    id_page_fk = EXCLUDED.id_page_fk,
    updated_at = NOW();
	`;
}

export async function deleteIndexByRefId(ref_id: string){
	await sql`
	DELETE FROM text_index WHERE ref_id = ${ref_id};
	`;
}
