"use server";
import { z } from 'zod';

import { revalidatePath } from "next/cache";
import { CreateSectionSchema, UpdateSectionSchema } from "@/lib/schemas";
import { 
  createSection, 
  updateSectionById, 
  deleteSectionById 
} from "@/lib/queries/contentCrudSection";

export async function createSectionAction(data: unknown, url?:string) {
  const validation = CreateSectionSchema.safeParse(data);

  if (!validation.success) {
    return z.treeifyError(validation.error);
  }

  try {
    const result = await createSection(validation.data);
    if(url){revalidatePath(url)}
    return { data: result };
  } catch (error) {
    console.error("Error creating section:", error);
    return { error: "Failed to create section" };
  }
}

export async function updateSectionAction(id: string, data: unknown, url?:string) {
  if (!id) {
    return { error: "Invalid section ID" };
  }

  const validation = UpdateSectionSchema.safeParse(data);

  if (!validation.success) {
    return z.treeifyError(validation.error);
  }

  try {
    const result = await updateSectionById(validation.data, id);
    
    if (!result) {
      return { error: "No changes made" };
    }

     if(url){revalidatePath(url)}
    return { data: result };
  } catch (error) {
    console.error("Error updating section:", error);
    return { error: "Failed to update section" };
  }
}

export async function deleteSectionAction(id: string, url?:string) {
  if (!id) {
    return { error: "Invalid section ID" };
  }

  try {
    await deleteSectionById(id);
     if(url){revalidatePath(url)}
    return { success: true };
  } catch (error) {
    console.error("Error deleting section:", error);
    return { error: "Failed to delete section" };
  }
}