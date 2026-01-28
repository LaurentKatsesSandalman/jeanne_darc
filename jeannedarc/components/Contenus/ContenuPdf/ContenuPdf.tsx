"use client";
import { ContenuPdfInterface } from "@/lib/schemas";
import styles from "./ContenuPdf.module.css";

interface ContenuPdfProps {
    contenu: ContenuPdfInterface;
}

export function ContenuPdf({ contenu }: ContenuPdfProps) {
    return (
        <>
            <div className={styles.downloadContainer}>
                <p className={styles.pdfTitle}>{contenu.pdf_titre}</p>
                <a
                    href={contenu.pdf_url}
                    download={contenu.pdf_titre}
                    className={styles.downloadBtn}
                >
                    Télécharger
                </a>
            </div>
			<iframe
				title={contenu.pdf_titre}
                src={contenu.pdf_url}
                className={styles.pdfContainer}
            ></iframe>
            {/* <div className={styles.downloadContainer}>
                <p className={styles.pdfTitle}>{contenu.pdf_titre}</p>
                <a
                    href={contenu.pdf_url}
                    download={contenu.pdf_titre}
                    className={styles.downloadBtn}
                >
                    Télécharger
                </a>
            </div> */}
        </>
    );
}
