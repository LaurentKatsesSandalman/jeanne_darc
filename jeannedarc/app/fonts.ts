import {IBM_Plex_Serif, Actor} from "next/font/google"

export const IBM_Plex = IBM_Plex_Serif({
  weight: ['400', '500', '600', '700'],
  subsets: ['latin'],
  variable: "--font-ibm-plex",
});

export const ActorFont = Actor ({
weight: ['400'],
  subsets: ['latin'],
  variable: "--font-actor",
})