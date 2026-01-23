"use server";

import { sql } from "../db";
import { CreateIndex, SearchIndexData } from "../schemas";
import { getPageByUrl } from "./contentCrudPage";

export async function createIndex(
    { ref_id, ref_table, content_plaintext }: CreateIndex,
    url: string,
): Promise<boolean> {
	console.log(url)
	const shortUrl=(url==="/"?"/":url.slice(1))
    const page = await getPageByUrl(shortUrl);

	

    if (!page) {
		console.log("no page")
        return false;
    }

console.log('🔍 DEBUG createIndex:', {
    ref_id,
    ref_table,
    content_plaintext: content_plaintext.substring(0, 50) + '...',
    id_page_fk: page.id_page
});

    const data = {
        id_page_fk: page.id_page,
        ref_table,
        ref_id,
        content_plaintext,
    };

    await sql`
	INSERT INTO text_index ${sql(data)}
	ON CONFLICT (ref_id)
	DO UPDATE 
	SET content_plaintext = EXCLUDED.content_plaintext,
    id_page_fk = EXCLUDED.id_page_fk,
    updated_at = NOW();
	`;
    return true;
}

export async function deleteIndexByRefId(ref_id: string) {
    await sql`
	DELETE FROM text_index WHERE ref_id = ${ref_id};
	`;
}

export async function searchIndex(
    search: string,
): Promise<SearchIndexData[] | undefined> {
    const rows = await sql<SearchIndexData[]>`
	SELECT 
            index.id_page_fk,
            string_agg(index.content_plaintext, ' ') as contenu_combine,
			page.nom as page_nom,
            page.page_url
        FROM text_index index
        JOIN page ON page.id_page = index.id_page_fk
        WHERE to_tsvector('french', index.content_plaintext) 
              @@ plainto_tsquery('french', ${search})
        GROUP BY index.id_page_fk, page.page_url, page_nom
	`;
    return rows;
}

export async function getIndexByUrl (url:string): Promise<SearchIndexData[] | undefined> {
	const rows = await sql<SearchIndexData[]>`
	SELECT 
            index.id_page_fk,
            string_agg(index.content_plaintext, ' ') as contenu_combine,
			page.nom as page_nom,
            page.page_url
        FROM text_index index
        JOIN page ON page.id_page = index.id_page_fk
        WHERE page.page_url = ${url}
        GROUP BY index.id_page_fk, page.page_url, page_nom
	`;
    return rows;
}