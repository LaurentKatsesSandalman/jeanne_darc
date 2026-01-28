import { HeaderMenu } from "./HeaderMenu";
import { SectionWithBtn } from "./HeaderServer";
import { Dispatch, SetStateAction } from "react";
import styles from "./Header.module.css";
import { CloseCancelIcon } from "../Icons/Icons";
import { FocusTrap } from "focus-trap-react";

interface HeaderMobileModalProps {
    sectionsWithBtn: SectionWithBtn[];
    setModalActive: Dispatch<SetStateAction<boolean>>;
}

export function HeaderMobileModal({
    sectionsWithBtn,
    setModalActive,
}: HeaderMobileModalProps) {
    return (
        <div
            onClick={() => setModalActive(false)}
            className={styles.menuModalContainer}
        >
            <FocusTrap focusTrapOptions={{
        escapeDeactivates: true,  // Échap désactive le trap
        clickOutsideDeactivates: true,  // Clic dehors désactive le trap
    }}>
                <div
                    className={styles.menuModal}
                    onClick={(e) => e.stopPropagation()}
                >
                    <button
                        onClick={() => setModalActive(false)}
                        className={styles.menuModalClose}
                        aria-label="Fermer le menu"
                    >
                        <CloseCancelIcon />
                    </button>
                    <HeaderMenu
                        sections={sectionsWithBtn}
                        setModalActive={setModalActive}
                    />
                    <a className={styles.numeroTel} href="tel:+33556085216">
                        (+33)5 56 08 52 16
                    </a>
                </div>
            </FocusTrap>
        </div>
    );
}
