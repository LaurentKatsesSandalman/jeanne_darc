import { PaveBlocInterface } from "@/lib/schemas";
import Link from "next/link";
import styles from "./ContenuPave.module.css";
import { IconDisplayer } from "@/components/utils/IconSelector/IconSelector";
import { usePathname } from "next/navigation";

interface ContenuPaveProps {
    contenu: PaveBlocInterface;
	existingTitle:boolean;
}

export function ContenuPave({ contenu, existingTitle }: ContenuPaveProps) {
    const url = usePathname();

    const isContactPage = url.startsWith("/contact");
    const isHome = url === "/";

    const classSuffixe = isContactPage ? "Contact" : isHome ? "Home" : "";

    return (
        <>
            {contenu.lien_vers ? (
                <Link href={contenu.lien_vers} className={styles[`linkBloc${classSuffixe}`]}>
                    <div className={styles[`containerBloc${classSuffixe}`]}>
                        {contenu.icone && (
                            <IconDisplayer
                                currentIcon={contenu.icone}
                                additionalClassName={isHome?styles.orange:""}
                            />
                        )}
						{existingTitle?(<h3 className={styles[`titreBloc${classSuffixe}`]}>
                            {contenu.soustitre}
                        </h3>):(<h2 className={styles[`titreBloc${classSuffixe}`]}>
                            {contenu.soustitre}
                        </h2>)}
                        
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
                            additionalClassName={isHome?styles.orange:""}
                        />
                    )}
                    {existingTitle?(<h3 className={styles[`titreBloc${classSuffixe}`]}>
                            {contenu.soustitre}
                        </h3>):(<h2 className={styles[`titreBloc${classSuffixe}`]}>
                            {contenu.soustitre}
                        </h2>)}
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
