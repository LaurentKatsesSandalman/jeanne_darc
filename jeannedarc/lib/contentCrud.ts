import { sql } from './db';

export async function getTextSectionByUrl(url: string) {
  const rows = await sql`
    SELECT * FROM textsection WHERE url = ${url};
  `;
  return rows[0];
}