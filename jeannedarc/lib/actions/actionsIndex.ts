"use server";

import { getIndexByUrl, searchIndex } from "../queries/indexCrud";
import { SearchIndexData, SearchIndexResult } from "../schemas";
import { textExtractor } from "./actions-utils";

export async function searchIndexAction(
    search: string,
    maxBefore = 120,
    maxAfter = 120,
): Promise<SearchIndexResult> {
    if (typeof search !== "string") {
        return { success: false, error: "Search is not a string" };
    }

    if (typeof maxBefore !== "number" || typeof maxAfter !== "number") {
        return {
            success: false,
            error: "maxBefore and maxAfter must be numbers",
        };
    }

    try {
        const results: SearchIndexData[] | undefined =
            await searchIndex(search);

        if (!results) {
            return {
                success: false,
                error: "Pas de résultats pour cette recherche",
            };
        }

        const computedResults = results.map((result) => ({
            ...result,
            extrait: textExtractor(
                result.contenu_combine,
                search,
                maxBefore,
                maxAfter,
            ),
        }));

        return { success: true, data: computedResults };
    } catch (error) {
        console.error("Error searching index:", error);
        return { success: false, error: "Failed to get index" };
    }
}

export async function getIndexByUrlAction(
    url: string,
    maxBefore = 120,
    maxAfter = 120,
): Promise<SearchIndexResult> {
    if (typeof url !== "string") {
        return { success: false, error: "Url is not a string" };
    }

    if (typeof maxBefore !== "number" || typeof maxAfter !== "number") {
        return {
            success: false,
            error: "maxBefore and maxAfter must be numbers",
        };
    }

    try {
        const results: SearchIndexData[] | undefined =
            await getIndexByUrl(url);

        if (!results) {
            return {
                success: false,
                error: "Pas de résultats pour cette recherche",
            };
        }

        const computedResults = results.map((result) => ({
            ...result,
            extrait: textExtractor(
                result.contenu_combine,
                url,
                maxBefore,
                maxAfter,
            ),
        }));

        return { success: true, data: computedResults };
    } catch (error) {
        console.error("Error searching index:", error);
        return { success: false, error: "Failed to get index" };
    }
}
