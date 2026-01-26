"use client";
import { useState } from "react";
import { MenuIcon } from "../Icons/Icons";
import { HeaderMobileModal } from "./HeaderMobileModal";
import { SectionWithBtn } from "./HeaderServer";

interface HeaderMobileClientProps {

		sectionsWithBtn: SectionWithBtn[];
}

export function HeaderMobileClient({ sectionsWithBtn}:HeaderMobileClientProps){
	const [modalActive, setModalActive] = useState(false)

	function toggleMenu(){
		setModalActive((prev)=>!prev)
	}

return(<>
	<button onClick={toggleMenu}><MenuIcon /></button>
	{modalActive&&<HeaderMobileModal setModalActive={setModalActive}  sectionsWithBtn={sectionsWithBtn} />}
	</>)

}