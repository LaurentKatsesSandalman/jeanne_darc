import { ContenuImageInterface } from "@/lib/schemas";
import Image from "next/image";
//import styles from "./ContenuImage.module.css";

interface ContenuImageProps {
    contenu: ContenuImageInterface;
}

export function ContenuImage({ contenu }: ContenuImageProps) {
    const imageElement = (
        <Image
            loading="eager"
            src={contenu.image_url}
            alt={contenu.alt_text}
            width={0}
            height={0}
            sizes="100vw"
            style={{ width: "100%", height: "auto" }}
        />
    );

    return (
        <>
            {contenu!.lien_vers ? (
                <a href={contenu.lien_vers} target="_blank">
                    {imageElement}
                </a>
            ) : (
                imageElement
            )}
        </>
    );
}
