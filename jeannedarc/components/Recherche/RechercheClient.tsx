"use client";
import { useState } from "react";
import { SearchIcon } from "../Icons/Icons";
import { RechercheModal } from "./RechercheModal";

export function RechercheClient () {
	const [modalActive, setModalActive] = useState(false)

	function toggleRecherche(){
		setModalActive((prev)=>!prev)
	}

	return(<>
	<button onClick={toggleRecherche}><SearchIcon /></button>
	{modalActive&&<RechercheModal setModalActive={setModalActive} />}
	</>)
}