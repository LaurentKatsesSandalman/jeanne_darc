"use client";
import { ContenuPdfInterface } from "@/lib/schemas";
import styles from "./ContenuPdf.module.css";

interface ContenuPdfProps {
    contenu: ContenuPdfInterface;
}

export function ContenuPdf({ contenu }: ContenuPdfProps) {
    return (
        <>
            <iframe 
				src={contenu.pdf_url}
				className={styles.pdfContainer}
				>
			</iframe>
			<p>{contenu.pdf_titre}</p>
        </>
    );
}
