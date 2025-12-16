"use server";

import { sql } from "../db";
import {
    ContenuImage,
    ContenuTexte,
    ContenuContact,
    ContenuPdf,
    ContenuTitre,
    ContenuPave,
    ContenuBandeauBtn,
    ContenuHeaderBtn,
    CreateContenuImage,
    CreateContenuTexte,
    CreateContenuContact,
    CreateContenuPdf,
    CreateContenuTitre,
    CreateContenuPave,
    CreateContenuBandeauBtn,
    CreateContenuHeaderBtn,
    UpdateContenuImage,
    UpdateContenuContact,
    UpdateContenuPdf,
    UpdateContenuTitre,
    UpdateContenuPave,
    UpdateContenuBandeauBtn,
    UpdateContenuHeaderBtn,
	UpdateContenuTexte,
} from "../schemas";

// contenu_titre
export async function createContenuTitre(
    payload: CreateContenuTitre
): Promise<ContenuTitre | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuTitre[]>`
	INSERT INTO contenu_titre ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuTitreById(
    id: string
): Promise<ContenuTitre | undefined> {
    const rows = await sql<ContenuTitre[]>`
	SELECT * FROM contenu_titre WHERE id_contenu_titre = ${id};
	`;
    return rows[0];
}

export async function getAllContenuTitresBySectionId(
    id_section: string
): Promise<ContenuTitre[] | undefined> {
    const rows = await sql<ContenuTitre[]>`
	SELECT * FROM contenu_titre WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuTitreById(
    payload: UpdateContenuTitre,
    id: string
): Promise<ContenuTitre | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuTitre[]>`
    UPDATE contenu_titre 
    SET ${sql(updates)} 
    WHERE id_contenu_titre = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuTitreById(id: string) {
    await sql`
	DELETE FROM contenu_titre WHERE id_contenu_titre = ${id};
	`;
}

// contenu_image
export async function createContenuImage(
    payload: CreateContenuImage
): Promise<ContenuImage | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuImage[]>`
	INSERT INTO contenu_image ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuImageById(
    id: string
): Promise<ContenuImage | undefined> {
    const rows = await sql<ContenuImage[]>`
	SELECT * FROM contenu_image WHERE id_contenu_image = ${id};
	`;
    return rows[0];
}

export async function getAllContenuImagesBySectionId(
    id_section: string
): Promise<ContenuImage[] | undefined> {
    const rows = await sql<ContenuImage[]>`
	SELECT * FROM contenu_image WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuImageById(
    payload: UpdateContenuImage,
    id: string
): Promise<ContenuImage | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuImage[]>`
    UPDATE contenu_image 
    SET ${sql(updates)} 
    WHERE id_contenu_image = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuImageById(id: string) {
    await sql`
	DELETE FROM contenu_image WHERE id_contenu_image = ${id};
	`;
}
// contenu_texte
export async function createContenuTexte(
    payload: CreateContenuTexte
): Promise<ContenuTexte | undefined> {
    const tiptap_content = JSON.parse(payload.tiptap_content);
    const id_section_fk = payload.id_section_fk;

    // 	const data = Object.fromEntries(
    //     Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
    //   );

    const rows = await sql<ContenuTexte[]>`
	INSERT INTO contenu_texte (id_section_fk, tiptap_content)
	VALUES (${id_section_fk}, ${sql.json(tiptap_content)})
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuTexteById(
    id: string
): Promise<ContenuTexte | undefined> {
    const rows = await sql<ContenuTexte[]>`
	SELECT * FROM contenu_texte WHERE id_contenu_texte = ${id};
	`;
    return rows[0];
}

export async function getAllContenuTextesBySectionId(
    id_section: string
): Promise<ContenuTexte[] | undefined> {
    const rows = await sql<ContenuTexte[]>`
	SELECT * FROM contenu_texte WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuTexteById(
    payload: UpdateContenuTexte,
    id: string
): Promise<ContenuTexte | undefined> {
    const updatedtiptap_content = JSON.parse(payload.tiptap_content);

    const rows = await sql<ContenuTexte[]>`
    UPDATE contenu_texte 
    SET tiptap_content = ${sql.json(updatedtiptap_content)}
    WHERE id_contenu_texte = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuTexteById(id: string) {
    await sql`
	DELETE FROM contenu_texte WHERE id_contenu_texte = ${id};
	`;
}

// contenu_contact
export async function createContenuContact(
    payload: CreateContenuContact
): Promise<ContenuContact | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuContact[]>`
	INSERT INTO contenu_contact ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuContactById(
    id: string
): Promise<ContenuContact | undefined> {
    const rows = await sql<ContenuContact[]>`
	SELECT * FROM contenu_contact WHERE id_contenu_contact = ${id};
	`;
    return rows[0];
}

export async function getAllContenuContactsBySectionId(
    id_section: string
): Promise<ContenuContact[] | undefined> {
    const rows = await sql<ContenuContact[]>`
	SELECT * FROM contenu_contact WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuContactById(
    payload: UpdateContenuContact,
    id: string
): Promise<ContenuContact | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuContact[]>`
    UPDATE contenu_contact 
    SET ${sql(updates)} 
    WHERE id_contenu_contact = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuContactById(id: string) {
    await sql`
	DELETE FROM contenu_contact WHERE id_contenu_contact = ${id};
	`;
}

// contenu_pdf
export async function createContenuPdf(
    payload: CreateContenuPdf
): Promise<ContenuPdf | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuPdf[]>`
	INSERT INTO contenu_pdf ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuPdfById(
    id: string
): Promise<ContenuPdf | undefined> {
    const rows = await sql<ContenuPdf[]>`
	SELECT * FROM contenu_pdf WHERE id_contenu_pdf = ${id};
	`;
    return rows[0];
}

export async function getAllContenuPdfsBySectionId(
    id_section: string
): Promise<ContenuPdf[] | undefined> {
    const rows = await sql<ContenuPdf[]>`
	SELECT * FROM contenu_pdf WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuPdfById(
    payload: UpdateContenuPdf,
    id: string
): Promise<ContenuPdf | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuPdf[]>`
    UPDATE contenu_pdf 
    SET ${sql(updates)} 
    WHERE id_contenu_pdf = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuPdfById(id: string) {
    await sql`
	DELETE FROM contenu_pdf WHERE id_contenu_pdf = ${id};
	`;
}

// contenu_pave
export async function createContenuPave(
    payload: CreateContenuPave
): Promise<ContenuPave | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuPave[]>`
	INSERT INTO contenu_pave ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuPaveById(
    id: string
): Promise<ContenuPave | undefined> {
    const rows = await sql<ContenuPave[]>`
	SELECT * FROM contenu_pave WHERE id_contenu_pave = ${id};
	`;
    return rows[0];
}

export async function getAllContenuPavesBySectionId(
    id_section: string
): Promise<ContenuPave[] | undefined> {
    const rows = await sql<ContenuPave[]>`
	SELECT * FROM contenu_pave WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuPaveById(
    payload: UpdateContenuPave,
    id: string
): Promise<ContenuPave | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuPave[]>`
    UPDATE contenu_pave 
    SET ${sql(updates)} 
    WHERE id_contenu_pave = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuPaveById(id: string) {
    await sql`
	DELETE FROM contenu_pave WHERE id_contenu_pave = ${id};
	`;
}

// contenu_bandeaubtn
export async function createContenuBandeauBtn(
    payload: CreateContenuBandeauBtn
): Promise<ContenuBandeauBtn | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuBandeauBtn[]>`
	INSERT INTO contenu_bandeaubtn ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuBandeauBtnById(
    id: string
): Promise<ContenuBandeauBtn | undefined> {
    const rows = await sql<ContenuBandeauBtn[]>`
	SELECT * FROM contenu_bandeaubtn WHERE id_contenu_bandeaubtn = ${id};
	`;
    return rows[0];
}

export async function getAllContenuBandeauBtnsBySectionId(
    id_section: string
): Promise<ContenuBandeauBtn[] | undefined> {
    const rows = await sql<ContenuBandeauBtn[]>`
	SELECT * FROM contenu_bandeaubtn WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuBandeauBtnById(
    payload: UpdateContenuBandeauBtn,
    id: string
): Promise<ContenuBandeauBtn | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuBandeauBtn[]>`
    UPDATE contenu_bandeaubtn 
    SET ${sql(updates)} 
    WHERE id_contenu_bandeaubtn = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuBandeauBtnById(id: string) {
    await sql`
	DELETE FROM contenu_bandeaubtn WHERE id_contenu_bandeaubtn = ${id};
	`;
}

// contenu_headerbtn
export async function createContenuHeaderBtn(
    payload: CreateContenuHeaderBtn
): Promise<ContenuHeaderBtn | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    const rows = await sql<ContenuHeaderBtn[]>`
	INSERT INTO contenu_headerbtn ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getContenuHeaderBtnById(
    id: string
): Promise<ContenuHeaderBtn | undefined> {
    const rows = await sql<ContenuHeaderBtn[]>`
	SELECT * FROM contenu_headerbtn WHERE id_contenu_headerbtn = ${id};
	`;
    return rows[0];
}

export async function getAllContenuHeaderBtnsBySectionId(
    id_section: string
): Promise<ContenuHeaderBtn[] | undefined> {
    const rows = await sql<ContenuHeaderBtn[]>`
	SELECT * FROM contenu_headerbtn WHERE id_section_fk = ${id_section};
	`;
    return rows;
}

export async function updateContenuHeaderBtnById(
    payload: UpdateContenuHeaderBtn,
    id: string
): Promise<ContenuHeaderBtn | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<ContenuHeaderBtn[]>`
    UPDATE contenu_headerbtn 
    SET ${sql(updates)} 
    WHERE id_contenu_headerbtn = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteContenuHeaderBtnById(id: string) {
    await sql`
	DELETE FROM contenu_headerbtn WHERE id_contenu_headerbtn = ${id};
	`;
}
