//https://developers.netlify.com/guides/user-generated-uploads-with-netlify-blobs/
import { getStore } from "@netlify/blobs";
import { auth } from "@clerk/nextjs/server";

export async function POST(request: Request) {
    const { userId } = await auth();
    if (!userId) {
		console.error("[SECURITY] Tentative d'upload non autorisée");
        return Response.json(
            { success: false, error: "Unauthorized" },
            { status: 401 },
        );
    }

    // Get form data from the request (assumes that `request` is the incoming
    // request object)
    const formData = await request.formData();
    // Get the file from the form data
    const fileUpload = formData.get("fileUpload") as File;
    const id_contenu = formData.get("id_contenu") as string;

    if (!fileUpload || !id_contenu) {
		console.error("[UPLOAD] Fichier ou ID manquant");
        return Response.json(
            { success: false, error: "Fichier ou identifiant manquant" },
            { status: 400 },
        );
    }

    const tailleMax = 10 * 1024 * 1024; // 10MB
    if (fileUpload.size > tailleMax) {
		console.warn(`[UPLOAD] Fichier trop volumineux: ${fileUpload.size} octets`);
        return Response.json(
            { success: false, error: "Fichier trop gros (max 9 Mo)" },
            { status: 400 },
        );
    }

    const fichiersPermis = [
        "image/jpeg",
        "image/png",
        "image/webp",
        "application/pdf",
    ];
    if (!fichiersPermis.includes(fileUpload.type)) {
		console.warn(`[UPLOAD] Type non autorisé: ${fileUpload.type}`);
        return Response.json(
            {
                success: false,
                error: "Le fichier n'est ni un pdf ni une image",
            },
            { status: 400 },
        );
    }

    // Load the Netlify Blobs store called `UserUpload`
    const userUploadStore = getStore({
        name: "UserUpload",
        siteID: process.env.NETLIFY_SITE_ID,
        token: process.env.NETLIFY_AUTH_TOKEN,
        consistency: "strong",
    });
    // Set the file in the store.
     // Stocker le fichier AVEC metadata du content type
        await userUploadStore.set(id_contenu, fileUpload, {
            metadata: { contentType: fileUpload.type }
        });
        
        console.log(`[UPLOAD] Succès: ${fileUpload.name} (${fileUpload.size} octets, ${fileUpload.type})`);
    // Redirect to a new page
    return Response.json({ success: true });
}
