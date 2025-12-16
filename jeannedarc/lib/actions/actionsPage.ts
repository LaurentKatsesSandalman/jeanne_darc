"use server";
import { z } from "zod";

import { revalidatePath } from "next/cache";
import { CreatePageSchema, UpdatePageSchema } from "@/lib/schemas";
import {
    createPage,
    updatePageById,
    deletePageById,
} from "@/lib/queries/contentCrudPage";

export async function createPageAction(data: unknown, url?: string) {
    const validation = CreatePageSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createPage(validation.data);
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating page:", error);
        return { success: false, error: "Failed to create page" };
    }
}

export async function updatePageAction(
    id: string,
    data: unknown,
    url?: string
) {
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

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating page:", error);
        return { success: false, error: "Failed to update page" };
    }
}

export async function deletePageAction(id: string, url?: string) {
    if (!id) {
        return { success: false, error: "Invalid page ID" };
    }

    try {
        await deletePageById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting page:", error);
        return { success: false, error: "Failed to delete page" };
    }
}
