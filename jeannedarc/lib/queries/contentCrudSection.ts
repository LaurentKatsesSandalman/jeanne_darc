"use server";

import { sql } from "../db";
import { CreateSection, SectionInterface, UpdateSection } from "../schemas";
import { v7 as uuidv7 } from 'uuid';

export async function createSection(
    payload: CreateSection
): Promise<SectionInterface | undefined> {
    const data = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );
	data.id_section = uuidv7();

    const rows = await sql<SectionInterface[]>`
	INSERT INTO section ${sql(data)} 
    RETURNING *
  `;
    return rows[0];
}

export async function getSectionById(id: string): Promise<SectionInterface | undefined> {
    const rows = await sql<SectionInterface[]>`
	SELECT * FROM section WHERE id_section = ${id};
	`;
    return rows[0];
}

export async function getAllSectionsByPageId(
    id_page: string
): Promise<SectionInterface[] | undefined> {
    const rows = await sql<SectionInterface[]>`
	SELECT * FROM section WHERE id_page_fk = ${id_page};
	`;
    return rows;
}

export async function updateSectionById(
    payload: UpdateSection,
    id: string
): Promise<SectionInterface | undefined> {
    const updates = Object.fromEntries(
        Object.entries(payload).filter(
            ([, value]) => value !== undefined && value !== null
        )
    );

    if (Object.keys(updates).length === 0) return undefined;

    const rows = await sql<SectionInterface[]>`
    UPDATE section 
    SET ${sql(updates)} 
    WHERE id_section = ${id}
    RETURNING *
  `;

    return rows[0];
}

export async function deleteSectionById(id: string) {
    await sql`
	DELETE FROM section WHERE id_section = ${id};
	`;
}
