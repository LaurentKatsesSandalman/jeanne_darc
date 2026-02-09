import type { Metadata } from "next";
import { ClerkProvider } from "@clerk/nextjs";
import { IBM_Plex, ActorFont } from "./fonts";
import "./globals.css";
import { HeaderServer } from "@/components/Header/HeaderServer";
import { FooterServer } from "@/components/Footer/FooterServer";
import { SchemaOrgSchool } from "@/components/SEO/SchemaOrgSchool";
import styles from "./layout.module.css";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
    title: {
        default: "École Jeanne d'Arc - Le Bouscat",
        template: "%s | École Jeanne d'Arc", // Pour les sous-pages
    },
    description:
        "École Jeanne d'Arc - Le Bouscat - École maternelle et primaire de l'enseignement catholique sous tutelle diocésaine.",
    icons: {
        icon: "/favicon.ico",
        apple: "/apple-touch-icon.png",
    },
    alternates: {
        canonical: "https://jeannedarc33.fr",
    },
    openGraph: {
        type: "website",
        locale: "fr_FR",
        url: "https://jeannedarc33.fr",
        siteName: "École Jeanne d'Arc - Le Bouscat",
        title: "École Jeanne d'Arc - Le Bouscat",
        description:
            "École maternelle et primaire de l'enseignement catholique sous tutelle diocésaine.",
        images: [
            {
                url: "/images/og-image.jpg", // Adapter l'extension si besoin
                width: 1200,
                height: 630,
                alt: "École Jeanne d'Arc - Le Bouscat",
            },
        ],
    },
    twitter: {
        card: "summary_large_image",
        title: "École Jeanne d'Arc - Le Bouscat",
        description:
            "École maternelle et primaire de l'enseignement catholique sous tutelle diocésaine.",
        images: ["/images/og-image.jpg"],
    },
};

export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return (
        <ClerkProvider>
            <html lang="fr">
                <body
                    className={`${IBM_Plex.variable} ${ActorFont.variable} antialiased`}
                >
                    <SchemaOrgSchool />
                    <a href="#main-content" className={styles.skipLink}>
                        Aller au contenu principal
                    </a>
                    <HeaderServer />
                    <>{children}</>
                    <FooterServer />
                </body>
            </html>
        </ClerkProvider>
    );
}
