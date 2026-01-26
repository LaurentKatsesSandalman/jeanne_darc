import { HeaderMenu } from "./HeaderMenu";
import { SectionWithBtn } from "./HeaderServer";
import { Dispatch, SetStateAction } from "react";
import styles from "./Header.module.css"
import { CloseCancelIcon } from "../Icons/Icons";

interface HeaderMobileModalProps {
	
	sectionsWithBtn: SectionWithBtn[];
	setModalActive: Dispatch<SetStateAction<boolean>>;
}

export function HeaderMobileModal({ sectionsWithBtn, setModalActive}:HeaderMobileModalProps){

	return(<div onClick={()=>setModalActive(false)} className={styles.menuModalContainer}>
		
	<div className={styles.menuModal} onClick={(e) => e.stopPropagation()}>
		<button onClick={()=>setModalActive(false)} className={styles.menuModalClose}><CloseCancelIcon/></button>
	<HeaderMenu  sections={sectionsWithBtn} setModalActive={setModalActive} />
					<a className={styles.numeroTel} href="tel:+33556085216">(+33)5 56 08 52 16</a>
					</div>
	</div>)
}