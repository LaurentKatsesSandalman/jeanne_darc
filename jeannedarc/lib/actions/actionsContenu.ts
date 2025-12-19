"use server";
import { z } from "zod";
import { auth } from "@clerk/nextjs/server";

import { revalidatePath } from "next/cache";
import {
    CreateContenuTitreSchema,
    UpdateContenuTitreSchema,
    CreateContenuImageSchema,
    UpdateContenuImageSchema,
    CreateContenuTexteSchema,
    UpdateContenuTexteSchema,
    CreateContenuContactSchema,
    UpdateContenuContactSchema,
    CreateContenuPdfSchema,
    UpdateContenuPdfSchema,
    CreateContenuPaveSchema,
    UpdateContenuPaveSchema,
    CreateContenuBandeauBtnSchema,
    UpdateContenuBandeauBtnSchema,
    CreateContenuHeaderBtnSchema,
    UpdateContenuHeaderBtnSchema,
    CreateUpdateContenuTitreResult,
	CreateUpdateContenuTexteResult,
	CreateContenuImage,
	CreateContenuTitre,
	CreateContenuPave,
	CreateContenuPdf,
	CreateContenuContact,
	CreateContenuTexte,
	UpdateContenuTexte,
	UpdateContenuImage,
	UpdateContenuTitre,
	UpdateContenuContact,
	UpdateContenuPdf,
	UpdateContenuPave,
	CreateContenuBandeauBtn,
	UpdateContenuBandeauBtn,
	CreateContenuHeaderBtn,
	UpdateContenuHeaderBtn,
	CreateUpdateContenuImageResult,
	CreateUpdateContenuContactResult,
	CreateUpdateContenuPdfResult,
	CreateUpdateContenuPaveResult,
	CreateUpdateContenuBandeauBtnResult,
	CreateUpdateContenuHeaderBtnResult,
} from "@/lib/schemas";
import {
    createContenuTitre,
    updateContenuTitreById,
    deleteContenuTitreById,
    createContenuImage,
    updateContenuImageById,
    deleteContenuImageById,
    createContenuTexte,
    updateContenuTexteById,
    deleteContenuTexteById,
    createContenuContact,
    updateContenuContactById,
    deleteContenuContactById,
    createContenuPdf,
    updateContenuPdfById,
    deleteContenuPdfById,
    createContenuPave,
    updateContenuPaveById,
    deleteContenuPaveById,
    createContenuBandeauBtn,
    updateContenuBandeauBtnById,
    deleteContenuBandeauBtnById,
    createContenuHeaderBtn,
    updateContenuHeaderBtnById,
    deleteContenuHeaderBtnById,
} from "@/lib/queries/contentCrudContenu";

// contenu_titre
export async function createContenuTitreAction(data: CreateContenuTitre, url?: string): Promise<CreateUpdateContenuTitreResult> {
    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
		
    const validation = CreateContenuTitreSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuTitre(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu titre:", error);
        return { success: false, error: "Failed to create contenu titre" };
    }
}

export async function updateContenuTitreAction(
    id: string,
    data: UpdateContenuTitre,
    url?: string
): Promise<CreateUpdateContenuTitreResult> {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuTitreSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuTitreById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu titre:", error);
        return { success: false, error: "Failed to update contenu titre" };
    }
}

export async function deleteContenuTitreAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuTitreById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu titre:", error);
        return { success: false, error: "Failed to delete contenu titre" };
    }
}

// contenu_image
export async function createContenuImageAction(data: CreateContenuImage, url?: string): Promise<CreateUpdateContenuImageResult> {
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuImageSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuImage(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu image:", error);
        return { success: false, error: "Failed to create contenu image" };
    }
}

export async function updateContenuImageAction(
    id: string,
    data: UpdateContenuImage,
    url?: string
) : Promise<CreateUpdateContenuImageResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuImageSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuImageById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu image:", error);
        return { success: false, error: "Failed to update contenu image" };
    }
}

export async function deleteContenuImageAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuImageById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu image:", error);
        return { success: false, error: "Failed to delete contenu image" };
    }
}

// contenu_texte
export async function createContenuTexteAction(data: CreateContenuTexte, url?: string): Promise<CreateUpdateContenuTexteResult> {
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuTexteSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuTexte(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu texte:", error);
        return { success: false, error: "Failed to create contenu texte" };
    }
}

export async function updateContenuTexteAction(
    id: string,
    data: UpdateContenuTexte,
    url?: string
):Promise<CreateUpdateContenuTexteResult> {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuTexteSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuTexteById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu texte:", error);
        return { success: false, error: "Failed to update contenu texte" };
    }
}

export async function deleteContenuTexteAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuTexteById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu texte:", error);
        return { success: false, error: "Failed to delete contenu texte" };
    }
}

// contenu_CONTACT
export async function createContenuContactAction(data: CreateContenuContact, url?: string): Promise<CreateUpdateContenuContactResult>  {
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuContactSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuContact(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu contact:", error);
        return { success: false, error: "Failed to create contenu contact" };
    }
}

export async function updateContenuContactAction(
    id: string,
    data: UpdateContenuContact,
    url?: string
) :Promise<CreateUpdateContenuContactResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuContactSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuContactById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu contact:", error);
        return { success: false, error: "Failed to update contenu contact" };
    }
}

export async function deleteContenuContactAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuContactById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu contact:", error);
        return { success: false, error: "Failed to delete contenu contact" };
    }
}

// contenu_PDF
export async function createContenuPdfAction(data: CreateContenuPdf, url?: string):Promise<CreateUpdateContenuPdfResult> {
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuPdfSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuPdf(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu pdf:", error);
        return { success: false, error: "Failed to create contenu pdf" };
    }
}

export async function updateContenuPdfAction(
    id: string,
    data: UpdateContenuPdf,
    url?: string
) :Promise<CreateUpdateContenuPdfResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuPdfSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuPdfById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu pdf:", error);
        return { success: false, error: "Failed to update contenu pdf" };
    }
}

export async function deleteContenuPdfAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuPdfById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu pdf:", error);
        return { success: false, error: "Failed to delete contenu pdf" };
    }
}

// contenu_PAVE
export async function createContenuPaveAction(data: CreateContenuPave, url?: string):Promise<CreateUpdateContenuPaveResult> {
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuPaveSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuPave(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu pave:", error);
        return { success: false, error: "Failed to create contenu pave" };
    }
}

export async function updateContenuPaveAction(
    id: string,
    data: UpdateContenuPave,
    url?: string
) :Promise<CreateUpdateContenuPaveResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuPaveSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuPaveById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu pave:", error);
        return { success: false, error: "Failed to update contenu pave" };
    }
}

export async function deleteContenuPaveAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuPaveById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu pave:", error);
        return { success: false, error: "Failed to delete contenu pave" };
    }
}

// contenu_BANDEAUBTN
export async function createContenuBandeauBtnAction(
    data: CreateContenuBandeauBtn,
    url?: string
) :Promise<CreateUpdateContenuBandeauBtnResult>{
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuBandeauBtnSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuBandeauBtn(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu bandeau btn:", error);
        return {
            success: false,
            error: "Failed to create contenu bandeau btn",
        };
    }
}

export async function updateContenuBandeauBtnAction(
    id: string,
    data: UpdateContenuBandeauBtn,
    url?: string
) :Promise<CreateUpdateContenuBandeauBtnResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuBandeauBtnSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuBandeauBtnById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu bandeau btn:", error);
        return {
            success: false,
            error: "Failed to update contenu bandeau btn",
        };
    }
}

export async function deleteContenuBandeauBtnAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuBandeauBtnById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu bandeau btn:", error);
        return {
            success: false,
            error: "Failed to delete contenu bandeau btn",
        };
    }
}

// contenu_HEADERBTN
export async function createContenuHeaderBtnAction(
    data: CreateContenuHeaderBtn,
    url?: string
) :Promise<CreateUpdateContenuHeaderBtnResult>{
	    const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }
	
    const validation = CreateContenuHeaderBtnSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await createContenuHeaderBtn(validation.data);
		if(!result){return { success: false, error: "Failed to create contenu" };}
        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error creating contenu header btn:", error);
        return { success: false, error: "Failed to create contenu header btn" };
    }
}

export async function updateContenuHeaderBtnAction(
    id: string,
    data: UpdateContenuHeaderBtn,
    url?: string
) :Promise<CreateUpdateContenuHeaderBtnResult>{
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    const validation = UpdateContenuHeaderBtnSchema.safeParse(data);

    if (!validation.success) {
        return { success: false, errors: z.treeifyError(validation.error) };
    }

    try {
        const result = await updateContenuHeaderBtnById(validation.data, id);

        if (!result) {
            return { success: false, error: "No changes made" };
        }

        if (url) {
            revalidatePath(url);
        }
        return { success: true, data: result };
    } catch (error) {
        console.error("Error updating contenu header btn:", error);
        return { success: false, error: "Failed to update contenu header btn" };
    }
}

export async function deleteContenuHeaderBtnAction(id: string, url?: string) {
const { userId } = await auth();

    if (!userId) {
        return { success: false, error: "Unauthorized" };
    }

    if (!id) {
        return { success: false, error: "Invalid ID" };
    }

    try {
        await deleteContenuHeaderBtnById(id);
        if (url) {
            revalidatePath(url);
        }
        return { success: true };
    } catch (error) {
        console.error("Error deleting contenu header btn:", error);
        return { success: false, error: "Failed to delete contenu header btn" };
    }
}
