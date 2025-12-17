"use server";

import { sql } from "../db";
import { CreatePage, PageInterface, UpdatePage } from "../schemas";
//import { v7 as uuidv7 } from 'uuid';

export async function createPage(
    payload: CreatePage
): Promise<PageInterface | undefined> {
	

    const cols = ["page_url"];
    const vals = [payload.page_url];

    if (payload.nom) {
        cols.push("nom");
        vals.push(payload.nom);
    }
    //sql(), parce que l'occurence s'appelle sql: transforme automatiquement un tableau en liste de colonnes séparées par virgules
    // voir insert dynamic dans https://www.npmjs.com/package/postgres
    const rows = await sql<PageInterface[]>`
	INSERT INTO page (${sql(cols)}) VALUES (${sql(vals)}) 
    RETURNING *
  `;
    return rows[0];
}

export async function getPageByUrl(url: string): Promise<PageInterface | undefined> {
    const rows = await sql<PageInterface[]>`
	SELECT * FROM page WHERE page_url = ${url};
	`;
    return rows[0];
}

export async function getPageById(id: string): Promise<PageInterface | undefined> {
    const rows = await sql<PageInterface[]>`
	SELECT * FROM page WHERE id_page = ${id};
	`;
    return rows[0];
}

export async function updatePageById(
    payload: UpdatePage,
    id: string
): Promise<PageInterface | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<PageInterface[]>`
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
