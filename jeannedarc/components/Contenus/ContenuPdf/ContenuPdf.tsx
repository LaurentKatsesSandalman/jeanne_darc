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
            ></iframe>
            <div className={styles.downloadContainer}>
                <p className={styles.pdfTitle}>{contenu.pdf_titre}</p>
                <a
                    href={contenu.pdf_url}
                    download
                    className={styles.downloadBtn}
                >
                    Télécharger
                </a>
            </div>
        </>
    );
}
