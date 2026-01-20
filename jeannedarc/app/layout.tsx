import type { Metadata } from "next";
import {ClerkProvider} from '@clerk/nextjs'
import { IBM_Plex, ActorFont } from "./fonts";
import "./globals.css";
import { HeaderServer } from "@/components/Header/HeaderServer";
import { FooterServer } from "@/components/Footer/FooterServer";
// import styles from "./layout.module.css"

export const dynamic = 'force-dynamic';

export const metadata: Metadata = {
title: {
    default: "École Jeanne d'Arc - Le Bouscat",
    template: "%s | École Jeanne d'Arc", // Pour les sous-pages
  },
  description: "École Jeanne d'Arc - Le Bouscat - ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE sous CONTRAT AVEC L'ETAT",
icons: {
    icon: '/favicon.ico',
	apple: '/apple-touch-icon.png',
  },
  openGraph: {
    type: 'website',
    locale: 'fr_FR',
    url: 'https://refonte.jeannedarc33.fr',
    siteName: "École Jeanne d'Arc - Le Bouscat",
    title: "École Primaire Jeanne d'Arc - Le Bouscat",
    description: "ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE sous CONTRAT AVEC L'ETAT",
    images: [
      {
        url: '/images/og-image.jpg', // Adapter l'extension si besoin
        width: 1200,
        height: 630,
        alt: "École Jeanne d'Arc - Le Bouscat",
      },
    ],
  },
   twitter: {
    card: 'summary_large_image',
    title: "École Primaire Jeanne d'Arc - Le Bouscat",
    description: "ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE sous CONTRAT AVEC L'ETAT",
    images: ['/images/og-image.jpg'],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
	 <ClerkProvider>
    <html lang="en">
      <body
        className={`${IBM_Plex.variable} ${ActorFont.variable} antialiased`}
      >
		<HeaderServer/>
			<div >
        {children}
			</div>
		<FooterServer/>
      </body>
    </html>
	</ClerkProvider>
  );
}
