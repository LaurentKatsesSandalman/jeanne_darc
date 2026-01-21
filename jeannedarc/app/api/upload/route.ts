//https://developers.netlify.com/guides/user-generated-uploads-with-netlify-blobs/
import { getStore } from "@netlify/blobs";

export async function POST(request: Request) {
    // Get form data from the request (assumes that `request` is the incoming
    // request object)
    const formData = await request.formData();
    // Get the file from the form data
    const fileUpload = formData.get("fileUpload") as File;
    const id_contenu = formData.get("id_contenu") as string;
    // Load the Netlify Blobs store called `UserUpload`
    const userUploadStore = getStore({
        name: "UserUpload",
        siteID: process.env.NETLIFY_SITE_ID,
        token: process.env.NETLIFY_AUTH_TOKEN,
        consistency: "strong",
    });
    // Set the file in the store. Replace `<key>` with a unique key for the file.
    await userUploadStore.set(id_contenu, fileUpload);
    // Redirect to a new page
    return Response.json({ success: true });
}