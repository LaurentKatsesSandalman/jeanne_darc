import { sql } from "../lib/db";
import { makePlaintext } from "../lib/actions/actions-utils";
import { createIndex, deleteIndexByRefId } from "../lib/queries/indexCrud";

async function indexPaveBloc() {
  try {
    // On récupère tous les pave_bloc avec leur page
    const paveBlocs = await sql`
      SELECT pb.*, p.id_page AS id_page_fk, p.page_url AS url
      FROM pave_bloc pb
      JOIN contenu_pave cp ON pb.id_contenu_pave_fk = cp.id_contenu_pave
      JOIN section s ON cp.id_section_fk = s.id_section
      JOIN page p ON s.id_page_fk = p.id_page
    `;

    console.log(`Found ${paveBlocs.length} pave_bloc entries`);

    // Boucle d'indexation
    for (const pb of paveBlocs) {
		await deleteIndexByRefId(pb.id_pave_bloc);

      const content_plaintext = makePlaintext([
        
        pb.soustitre,
        pb.description1,
        pb.description2,
        pb.description3,
        pb.description4,
        pb.description5,
        pb.description6,
        pb.description7,
        
      ]);

      if (content_plaintext) {
        await createIndex({
          ref_id: pb.id_pave_bloc,
          ref_table: "pave_bloc",
          content_plaintext
        }, pb.url);
      }
    }

    console.log(`Indexation des pave_bloc terminée !`);
  } catch (error) {
    console.error("Erreur lors de l'indexation des pave_bloc :", error);
  }
}

// Lancer le script si exécuté directement
if (require.main === module) {
  indexPaveBloc().then(() => process.exit(0));
}
