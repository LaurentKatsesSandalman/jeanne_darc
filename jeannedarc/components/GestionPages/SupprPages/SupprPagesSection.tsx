import { SectionWithBtn } from "../../Header/HeaderServer";
import styles from "./SupprPages.module.css";
import { SupprPagesContentEdit } from "./SupprPagesContentEdit";

interface SupprPagesSectionProps {
    section: SectionWithBtn;
}

export function SupprPagesSection({ section }: SupprPagesSectionProps) {
    return (
        <>
            <div className={styles.editContainer}>
                {section.map((btn) => (
                    <SupprPagesContentEdit
                        key={btn.id_contenu_headerbtn}
                        btn={btn}
                    />
                ))}
            </div>
        </>
    );
}
