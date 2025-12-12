"use server"

import { sql } from './db';
import { ContenuImageInterface, ContenuTexteInterface, ContenuContactInterface, ContenuPdfInterface, ContenuTitreInterface, ContenuPaveInterface, ContenuBandeauBtnInterface, ContenuHeaderBtnInterface  } from './definitions';

// contenu_titre
export async function createContenuTitre(payload:Omit<ContenuTitreInterface, "id_contenu_titre">):Promise<ContenuTitreInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuTitreInterface[]>`
	INSERT INTO contenu_titre ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuTitreById(id:string):Promise<ContenuTitreInterface |undefined>{
	const rows = await sql<ContenuTitreInterface[]>`
	SELECT * FROM contenu_titre WHERE id_contenu_titre = ${id};
	`;
	return rows[0];
}

export async function getAllContenuTitresBySectionId(id_section:string):Promise<ContenuTitreInterface[] |undefined>{
	const rows = await sql<ContenuTitreInterface[]>`
	SELECT * FROM contenu_titre WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuTitreById(payload:Partial<Omit<ContenuTitreInterface, "id_contenu_titre">>,id:string): Promise<ContenuTitreInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuTitreInterface[]>`
    UPDATE contenu_titre 
    SET ${sql(updates)} 
    WHERE id_contenu_titre = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuTitreById(id:string){
	await sql`
	DELETE FROM contenu_titre WHERE id_contenu_titre = ${id};
	`;
}

// contenu_image
export async function createContenuImage(payload:Omit<ContenuImageInterface, "id_contenu_image">):Promise<ContenuImageInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuImageInterface[]>`
	INSERT INTO contenu_image ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuImageById(id:string):Promise<ContenuImageInterface |undefined>{
	const rows = await sql<ContenuImageInterface[]>`
	SELECT * FROM contenu_image WHERE id_contenu_image = ${id};
	`;
	return rows[0];
}

export async function getAllContenuImagesBySectionId(id_section:string):Promise<ContenuImageInterface[] |undefined>{
	const rows = await sql<ContenuImageInterface[]>`
	SELECT * FROM contenu_image WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuImageById(payload:Partial<Omit<ContenuImageInterface, "id_contenu_image">>,id:string): Promise<ContenuImageInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuImageInterface[]>`
    UPDATE contenu_image 
    SET ${sql(updates)} 
    WHERE id_contenu_image = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuImageById(id:string){
	await sql`
	DELETE FROM contenu_image WHERE id_contenu_image = ${id};
	`;
}
// contenu_texte
export async function createContenuTexte(payload:Omit<ContenuTexteInterface, "id_contenu_texte">):Promise<ContenuTexteInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuTexteInterface[]>`
	INSERT INTO contenu_texte ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuTexteById(id:string):Promise<ContenuTexteInterface |undefined>{
	const rows = await sql<ContenuTexteInterface[]>`
	SELECT * FROM contenu_texte WHERE id_contenu_texte = ${id};
	`;
	return rows[0];
}

export async function getAllContenuTextesBySectionId(id_section:string):Promise<ContenuTexteInterface[] |undefined>{
	const rows = await sql<ContenuTexteInterface[]>`
	SELECT * FROM contenu_texte WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuTexteById(tiptap_content: string, id:string): Promise<ContenuTexteInterface | undefined> {

const updatedtiptap_content = JSON.parse(tiptap_content);

  const rows = await sql<ContenuTexteInterface[]>`
    UPDATE contenu_texte 
    SET tiptap_content = ${sql.json(updatedtiptap_content)}
    WHERE id_contenu_texte = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuTexteById(id:string){
	await sql`
	DELETE FROM contenu_texte WHERE id_contenu_texte = ${id};
	`;
}

// contenu_contact
export async function createContenuContact(payload:Omit<ContenuContactInterface, "id_contenu_contact">):Promise<ContenuContactInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuContactInterface[]>`
	INSERT INTO contenu_contact ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuContactById(id:string):Promise<ContenuContactInterface |undefined>{
	const rows = await sql<ContenuContactInterface[]>`
	SELECT * FROM contenu_contact WHERE id_contenu_contact = ${id};
	`;
	return rows[0];
}

export async function getAllContenuContactsBySectionId(id_section:string):Promise<ContenuContactInterface[] |undefined>{
	const rows = await sql<ContenuContactInterface[]>`
	SELECT * FROM contenu_contact WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuContactById(payload:Partial<Omit<ContenuContactInterface, "id_contenu_contact">>,id:string): Promise<ContenuContactInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuContactInterface[]>`
    UPDATE contenu_contact 
    SET ${sql(updates)} 
    WHERE id_contenu_contact = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuContactById(id:string){
	await sql`
	DELETE FROM contenu_contact WHERE id_contenu_contact = ${id};
	`;
}

// contenu_pdf
export async function createContenuPdf(payload:Omit<ContenuPdfInterface, "id_contenu_pdf">):Promise<ContenuPdfInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuPdfInterface[]>`
	INSERT INTO contenu_pdf ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuPdfById(id:string):Promise<ContenuPdfInterface |undefined>{
	const rows = await sql<ContenuPdfInterface[]>`
	SELECT * FROM contenu_pdf WHERE id_contenu_pdf = ${id};
	`;
	return rows[0];
}

export async function getAllContenuPdfsBySectionId(id_section:string):Promise<ContenuPdfInterface[] |undefined>{
	const rows = await sql<ContenuPdfInterface[]>`
	SELECT * FROM contenu_pdf WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuPdfById(payload:Partial<Omit<ContenuPdfInterface, "id_contenu_pdf">>,id:string): Promise<ContenuPdfInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuPdfInterface[]>`
    UPDATE contenu_pdf 
    SET ${sql(updates)} 
    WHERE id_contenu_pdf = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuPdfById(id:string){
	await sql`
	DELETE FROM contenu_pdf WHERE id_contenu_pdf = ${id};
	`;
}

// contenu_pave
export async function createContenuPave(payload:Omit<ContenuPaveInterface, "id_contenu_pave">):Promise<ContenuPaveInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuPaveInterface[]>`
	INSERT INTO contenu_pave ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuPaveById(id:string):Promise<ContenuPaveInterface |undefined>{
	const rows = await sql<ContenuPaveInterface[]>`
	SELECT * FROM contenu_pave WHERE id_contenu_pave = ${id};
	`;
	return rows[0];
}

export async function getAllContenuPavesBySectionId(id_section:string):Promise<ContenuPaveInterface[] |undefined>{
	const rows = await sql<ContenuPaveInterface[]>`
	SELECT * FROM contenu_pave WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuPaveById(payload:Partial<Omit<ContenuPaveInterface, "id_contenu_pave">>,id:string): Promise<ContenuPaveInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuPaveInterface[]>`
    UPDATE contenu_pave 
    SET ${sql(updates)} 
    WHERE id_contenu_pave = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuPaveById(id:string){
	await sql`
	DELETE FROM contenu_pave WHERE id_contenu_pave = ${id};
	`;
}

// contenu_bandeaubtn
export async function createContenuBandeauBtn(payload:Omit<ContenuBandeauBtnInterface, "id_contenu_bandeaubtn">):Promise<ContenuBandeauBtnInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuBandeauBtnInterface[]>`
	INSERT INTO contenu_bandeaubtn ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuBandeauBtnById(id:string):Promise<ContenuBandeauBtnInterface |undefined>{
	const rows = await sql<ContenuBandeauBtnInterface[]>`
	SELECT * FROM contenu_bandeaubtn WHERE id_contenu_bandeaubtn = ${id};
	`;
	return rows[0];
}

export async function getAllContenuBandeauBtnsBySectionId(id_section:string):Promise<ContenuBandeauBtnInterface[] |undefined>{
	const rows = await sql<ContenuBandeauBtnInterface[]>`
	SELECT * FROM contenu_bandeaubtn WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuBandeauBtnById(payload:Partial<Omit<ContenuBandeauBtnInterface, "id_contenu_bandeaubtn">>,id:string): Promise<ContenuBandeauBtnInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuBandeauBtnInterface[]>`
    UPDATE contenu_bandeaubtn 
    SET ${sql(updates)} 
    WHERE id_contenu_bandeaubtn = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuBandeauBtnById(id:string){
	await sql`
	DELETE FROM contenu_bandeaubtn WHERE id_contenu_bandeaubtn = ${id};
	`;
}

// contenu_headerbtn
export async function createContenuHeaderBtn(payload:Omit<ContenuHeaderBtnInterface, "id_contenu_headerbtn">):Promise<ContenuHeaderBtnInterface |undefined>{
 
	const data = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

	const rows = await sql<ContenuHeaderBtnInterface[]>`
	INSERT INTO contenu_headerbtn ${sql(data)} 
    RETURNING *
  `;
  return rows[0];
}

export async function getContenuHeaderBtnById(id:string):Promise<ContenuHeaderBtnInterface |undefined>{
	const rows = await sql<ContenuHeaderBtnInterface[]>`
	SELECT * FROM contenu_headerbtn WHERE id_contenu_headerbtn = ${id};
	`;
	return rows[0];
}

export async function getAllContenuHeaderBtnsBySectionId(id_section:string):Promise<ContenuHeaderBtnInterface[] |undefined>{
	const rows = await sql<ContenuHeaderBtnInterface[]>`
	SELECT * FROM contenu_headerbtn WHERE id_section_fk = ${id_section};
	`;
	return rows;
}

export async function updateContenuHeaderBtnById(payload:Partial<Omit<ContenuHeaderBtnInterface, "id_contenu_headerbtn">>,id:string): Promise<ContenuHeaderBtnInterface | undefined> {

   const updates = Object.fromEntries(
    Object.entries(payload).filter(([, value]) => value !== undefined && value !== null)
  );

  if (Object.keys(updates).length === 0) return undefined;

  const rows = await sql<ContenuHeaderBtnInterface[]>`
    UPDATE contenu_headerbtn 
    SET ${sql(updates)} 
    WHERE id_contenu_headerbtn = ${id}
    RETURNING *
  `;

  return rows[0];
}

export async function deleteContenuHeaderBtnById(id:string){
	await sql`
	DELETE FROM contenu_headerbtn WHERE id_contenu_headerbtn = ${id};
	`;
}
