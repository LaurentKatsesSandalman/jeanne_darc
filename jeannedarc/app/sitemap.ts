import { MetadataRoute } from "next";
import { sql } from "@/lib/db";

interface PageFromDB {
    page_url: string;
    updated_at: Date;
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
    const baseUrl = "https://jeannedarc33.fr";

    try {
        // Récupérer toutes les pages depuis la BDD
        const pages = await sql<PageFromDB[]>`
            SELECT page_url, updated_at 
            FROM page 
            WHERE page_url NOT IN ('plus', 'recherche', 'footer', 'header')
            ORDER BY page_url
        `;

        // Mapper les pages au format sitemap
        const pageEntries: MetadataRoute.Sitemap = pages.map((page) => ({
            url: `${baseUrl}/${page.page_url === "/" ? "" : page.page_url}`,
            lastModified: new Date(), // Date du jour, pour éviter un JOIN sur 11 tables !!
            changeFrequency: "monthly" as const,
            priority: page.page_url === "/" ? 1.0 : 0.8,
        }));

        pageEntries.push({
            url: `${baseUrl}/mentions-legales`,
            lastModified: new Date('2026-01-27'),
            changeFrequency: "yearly" as const,
            priority: 0.3,
        });

        return pageEntries;
    } catch (error) {
        console.error("Erreur lors de la génération du sitemap:", error);

        // Fallback : au minimum la homepage
        return [
            {
                url: baseUrl,
                lastModified: new Date(),
                changeFrequency: "monthly" as const,
                priority: 1.0,
            },
        ];
    }
}
