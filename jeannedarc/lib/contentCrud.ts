"use server"

import { sql } from './db';
//import { ContenuTipTap } from './definitions';

export async function getTextSectionByUrl(url: string) {
  const rows = await sql`
    SELECT * FROM textsection WHERE url = ${url};
  `;
  return rows[0];
}

// Nouvelle fonction qui accepte une string
export async function updateTextSectionByUrlString(contenuString: string, url: string) {
    const contenu = JSON.parse(contenuString);
    
    const rows = await sql`
    UPDATE TEXTSECTION SET content = ${sql.json(contenu)} WHERE url = ${url} RETURNING *;
    `;
      
    return rows[0];
}