"use server";

import { sql } from "../db";
import { CreatePage, Page, UpdatePage } from "../schemas";

export async function createPage(
    payload: CreatePage
): Promise<Page | undefined> {
    const cols = ["page_url"];
    const vals = [payload.page_url];

    if (payload.nom) {
        cols.push("nom");
        vals.push(payload.nom);
    }
    //sql(), parce que l'occurence s'appelle sql: transforme automatiquement un tableau en liste de colonnes séparées par virgules
    // voir insert dynamic dans https://www.npmjs.com/package/postgres
    const rows = await sql<Page[]>`
	INSERT INTO page (${sql(cols)}) VALUES (${sql(vals)}) 
    RETURNING *
  `;
    return rows[0];
}

export async function getPageByUrl(url: string): Promise<Page | undefined> {
    const rows = await sql<Page[]>`
	SELECT * FROM page WHERE page_url = ${url};
	`;
    return rows[0];
}

export async function getPageById(id: string): Promise<Page | undefined> {
    const rows = await sql<Page[]>`
	SELECT * FROM page WHERE id_page = ${id};
	`;
    return rows[0];
}

export async function updatePageById(
    payload: UpdatePage,
    id: string
): Promise<Page | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<Page[]>`
    UPDATE page 
    SET ${sql(updates)} 
    WHERE id_page = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deletePageById(id: string) {
    await sql`
	DELETE FROM page WHERE id_page = ${id};
	`;
}

// export async function getTextSectionByUrl(url: string): Promise<ContenuTexteInterface |undefined> {
//   const rows = await sql<ContenuTexteInterface[]>`
//     SELECT * FROM textsection WHERE url = ${url};
//   `;
//   return rows[0];
// }

// // Nouvelle fonction qui accepte une string
// export async function updateTextSectionByUrlString(contenuString: string, url: string) {
//     const contenu = JSON.parse(contenuString);

//     const rows = await sql`
//     UPDATE TEXTSECTION SET content = ${sql.json(contenu)} WHERE url = ${url} RETURNING *;
//     `;
//     return rows[0];
// }
