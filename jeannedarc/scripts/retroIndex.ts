/* eslint-disable @typescript-eslint/no-explicit-any */

import { sql } from "../lib/db";
import { makePlaintext } from "../lib/actions/actions-utils";
import { createIndex } from "../lib/queries/indexCrud";

// Mapping table → fonction pour récupérer le texte à indexer
const tablesToIndex = {
  "page": (row: any) => makePlaintext([row.nom]),
  "contenu_titre": (row: any) => makePlaintext([row.description, row.titre1, row.titre2]),
  "contenu_texte": (row: any) => makePlaintext([], row.tiptap_content),
  "contenu_contact": (row: any) => makePlaintext([row.titre, row.champ1, row.champ2, row.champ3, row.champ4, row.bouton]),
  "contenu_pdf": (row: any) => makePlaintext([row.pdf_titre]),
  "contenu_pave": (row: any) => makePlaintext([row.titre]),
//   "pave_bloc": (row: any) => makePlaintext([row.icone, row.soustitre, row.description1, row.description2, row.description3, row.description4, row.description5, row.description6, row.description7]),
  "contenu_bandeaubtn": (row: any) => makePlaintext([row.titre, row.description, row.bouton]),
  "contenu_solobtn": (row: any) => makePlaintext([row.bouton]),
};

// Fonction principale d'indexation pour une page donnée
async function indexAllForPage(url: string) {
  console.log(`Indexation pour page: ${url}`);
  for (const [table, toPlaintext] of Object.entries(tablesToIndex)) {
    // Récupérer tous les enregistrements liés à cette page
    let rows: any[] = [];
    if (table === "page") {
      rows = await sql`SELECT * FROM page WHERE page_url = ${url}`;
    } else {
      // Pour les autres tables, on doit joindre section → page pour filtrer par page
      rows = await sql`
        SELECT t.*
        FROM ${sql(table)} t
        JOIN section s ON t.id_section_fk = s.id_section
        JOIN page p ON s.id_page_fk = p.id_page
        WHERE p.page_url = ${url}
      `;
    }

    for (const row of rows) {
      const content_plaintext = toPlaintext(row);
      const idField = table === "page" ? "id_page" : `id_${table}`;
      if (content_plaintext) {
        await createIndex({ ref_id: row[idField], ref_table: table as any, content_plaintext }, url);
      } else {
        await sql`DELETE FROM text_index WHERE ref_id = ${row[idField]}`;
      }
    }

    console.log(`Indexation terminée pour la table ${table} sur ${url}`);
  }
}

// Fonction pour lancer l’indexation sur **toutes les pages**
async function indexAllPages() {
  const pages: { page_url: string }[] = await sql`SELECT page_url FROM page`;
  for (const { page_url } of pages) {
    await indexAllForPage(page_url);
  }
  console.log("Indexation complète pour toutes les pages !");
}

// Exécution si lancé directement
if (require.main === module) {
  indexAllPages()
    .then(() => process.exit(0))
    .catch(err => {
      console.error(err);
      process.exit(1);
    });
}

export { indexAllForPage, indexAllPages };