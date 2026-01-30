//https://developers.netlify.com/guides/user-generated-uploads-with-netlify-blobs/
import { getStore } from "@netlify/blobs";

export async function GET(request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  const id_contenu = id;

  // Load the Netlify Blobs store called `UserUpload`
  const userUploadStore = getStore({
        name: "UserUpload",
        siteID: process.env.NETLIFY_SITE_ID,
        token: process.env.NETLIFY_AUTH_TOKEN,
        consistency: "strong",
    });

const metadata = await userUploadStore.getMetadata(id_contenu);
  
  if (!metadata) {
    return new Response("Upload not found", { status: 404 });
  }

  // Get the blob from the store. Replace `<key>` with the unique key used when
  // uploading.
  const userUploadBlob = await userUploadStore.get(id_contenu, {
    type: "stream",
  });
  // Make sure you throw a 404 if the blob is not found.
  if (!userUploadBlob) {
    return new Response("Upload not found", { status: 404 });
  }

// Get content type from custom metadata, fallback to octet-stream
  const contentType = (metadata.metadata as { contentType?: string })?.contentType || 'application/octet-stream';




  // Return the blob
  return new Response(userUploadBlob, {
    headers: {
      'Content-Type': contentType,
      'Cache-Control': 'public, max-age=0, must-revalidate',
    },
  });
}