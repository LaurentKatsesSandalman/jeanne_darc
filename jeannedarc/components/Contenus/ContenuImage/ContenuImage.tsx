import { ContenuImageInterface } from "@/lib/schemas";
//import styles from "./ContenuImage.module.css";

interface ContenuImageProps {
    contenu: ContenuImageInterface;
}

export function ContenuImage({ contenu }: ContenuImageProps) {
    return (
        <>
            {contenu!.lien_vers ? (
				<a href={contenu.lien_vers} target="_blank">
                {/* <Image src={contenu.image_url} alt={contenu.alt_text} fill={true} style={{ objectFit: 'contain' }}/> */}
				<img src={contenu.image_url} alt={contenu.alt_text}/>
				</a>
            ) : (
                // <Image src={contenu.image_url} alt={contenu.alt_text} fill={true} style={{ objectFit: 'contain' }}/>
				<img src={contenu.image_url} alt={contenu.alt_text}/>
            )}
        </>
    );
}
