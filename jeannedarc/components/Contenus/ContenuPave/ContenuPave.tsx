import { PaveBlocInterface } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ContenuPave.module.css";
import { IconDisplayer } from "@/components/utils/IconSelector/IconSelector";
import { usePathname } from "next/navigation";

interface ContenuPaveProps {
    contenu: PaveBlocInterface;
}

export function ContenuPave({ contenu }: ContenuPaveProps) {
    const url = usePathname();

    const isContactPage = url.startsWith("/contact");
    const isHome = url === "/";

    const classSuffixe = isContactPage ? "Contact" : isHome ? "Home" : "";

    return (
        <>
            {contenu.lien_vers ? (
                <Link href={contenu.lien_vers}>
                    <div className={styles[`containerBloc${classSuffixe}`]}>
                        {contenu.icone && (
                            <IconDisplayer
                                currentIcon={contenu.icone}
                                additionalClassName={""}
                            />
                        )}
                        <p className={styles[`titreBloc${classSuffixe}`]}>
                            {contenu.soustitre}
                        </p>
                        <div
                            className={styles[`descriptionBloc${classSuffixe}`]}
                        >
                            {contenu.description1 && (
                                <p>{contenu.description1}</p>
                            )}
                            {contenu.description2 && (
                                <p>{contenu.description2}</p>
                            )}
                            {contenu.description3 && (
                                <p>{contenu.description3}</p>
                            )}
                            {contenu.description4 && (
                                <p>{contenu.description4}</p>
                            )}
                            {contenu.description5 && (
                                <p>{contenu.description5}</p>
                            )}
                            {contenu.description6 && (
                                <p>{contenu.description6}</p>
                            )}
                            {contenu.description7 && (
                                <p>{contenu.description7}</p>
                            )}
                        </div>
                    </div>
                </Link>
            ) : (
                <div className={styles[`containerBloc${classSuffixe}`]}>
                    {contenu.icone && (
                        <IconDisplayer
                            currentIcon={contenu.icone}
                            additionalClassName={""}
                        />
                    )}
                    <p className={styles[`titreBloc${classSuffixe}`]}>
                        {contenu.soustitre}
                    </p>
                    <div className={styles[`descriptionBloc${classSuffixe}`]}>
                        {contenu.description1 && <p>{contenu.description1}</p>}
                        {contenu.description2 && <p>{contenu.description2}</p>}
                        {contenu.description3 && <p>{contenu.description3}</p>}
                        {contenu.description4 && <p>{contenu.description4}</p>}
                        {contenu.description5 && <p>{contenu.description5}</p>}
                        {contenu.description6 && <p>{contenu.description6}</p>}
                        {contenu.description7 && <p>{contenu.description7}</p>}
                    </div>
                </div>
            )}
        </>
    );
}
