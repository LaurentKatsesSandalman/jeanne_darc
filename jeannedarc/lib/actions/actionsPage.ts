"use server";

import { z } from "zod";
import { auth } from "@clerk/nextjs/server";

import { revalidatePath } from "next/cache";
import {
    CreatePage,
    CreatePageSchema,
    CreateUpdatePageResult,
    UpdatePage,
    UpdatePageSchema,
} from "@/lib/schemas";
import {
    createPage,
    updatePageById,
    deletePageById,
} from "@/lib/queries/contentCrudPage";
import { makePlaintext } from "./actions-utils";
import { createIndex, deleteIndexByRefId } from "../queries/indexCrud";

export async function createPageAction(
    data: CreatePage,
): Promise<CreateUpdatePageResult> {
    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    const validation = CreatePageSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createPage(validation.data);
        if (!result) {
            return { success: false, error: "Failed to create page" };
        }

        const content_plaintext = makePlaintext([result.nom]);
        if (content_plaintext) {
            await createIndex(
                {
                    ref_id: result.id_page,
                    ref_table: "page",
                    content_plaintext,
                },
                result.page_url,
            );
        }

        if (content_plaintext === "") {
            await deleteIndexByRefId(result.id_page);
        }

        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating page:", error);
        return { success: false, error: "Failed to create page" };
    }
}

export async function updatePageAction(
    id: string,
    data: UpdatePage,
): Promise<CreateUpdatePageResult> {
    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid page ID" };
    }

    const validation = UpdatePageSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updatePageById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        const content_plaintext = makePlaintext([result.nom]);
        if (content_plaintext) {
            await createIndex(
                {
                    ref_id: result.id_page,
                    ref_table: "page",
                    content_plaintext,
                },
                result.page_url,
            );
        }

        if (content_plaintext === "") {
            await deleteIndexByRefId(result.id_page);
        }

        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating page:", error);
        return { success: false, error: "Failed to update page" };
    }
}

export async function deletePageAction(id: string, url?: string) {
    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid page ID" };
    }

    try {
        await deletePageById(id);
        await deleteIndexByRefId(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting page:", error);
        return { success: false, error: "Failed to delete page" };
    }
}
