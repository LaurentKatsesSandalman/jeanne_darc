import { searchIndexAction } from "@/lib/actions/actionsIndex";
import { SearchIndexResult } from "@/lib/schemas";
import React from "react";
import Link from "next/link";
import styles from "./page.module.css"
import { ResultatRecherche } from "@/components/ResultatRecherche/ResultatRecherche";

export default async function Page({
    searchParams,
}: {
    searchParams: Promise<{ q?: string }>;
}) {
    const params = await searchParams;
	const recherche = await params.q || "";
    const resultats: SearchIndexResult | null = recherche
        ? await searchIndexAction(recherche)
        : null;

	const noResult = (!resultats || (resultats.success&&resultats.data.length === 0) || !resultats.success)

    return (
        <main>
            <h1>Titre à trouver</h1>
            <div className={styles.resultGrid}>
				{noResult&&<h2>Pas de résultat</h2>}
                {resultats?.success &&
                    resultats.data.map((resultat) => (
                        <ResultatRecherche resultat={resultat} key={resultat.id_page_fk} />
                    ))}
            </div>
        </main>
    );
}
