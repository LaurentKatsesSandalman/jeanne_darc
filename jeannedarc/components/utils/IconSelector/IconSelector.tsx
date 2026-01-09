import * as BigIcons from "@/components/Icons/BigIcons"
import { Dispatch, SetStateAction } from "react"
import clsx from "clsx";
import styles from "./IconSelector.module.css"

interface IconSelectorProps {
	currentIcon: string;
	setCurrentIcon: Dispatch<SetStateAction<string>>;
	additionalClassName?: string;
}

interface IconDisplayerProps {
	currentIcon: string;
	additionalClassName?: string;
}

export function IconSelector ({currentIcon, setCurrentIcon, additionalClassName}:IconSelectorProps) {


return (<div className={styles.iconGrid} role="radiogroup" aria-label="Choix d’icône">
{Object.entries(BigIcons).map(([iconName, IconComponent])=>(
	<button key={iconName} onClick={()=>setCurrentIcon(iconName)} className={clsx( (currentIcon === iconName) && 'selected', styles.bigIcon, additionalClassName )}  aria-checked={currentIcon === iconName} role="radio">
		<IconComponent/>
	</button>
))}
</div>)
}

export function IconDisplayer ({currentIcon, additionalClassName}:IconDisplayerProps) {
	type IconList = keyof typeof BigIcons
	const validCurrentIcon = currentIcon as IconList
	const DynamicBigIcon = BigIcons[validCurrentIcon]

	return (<>
	{DynamicBigIcon && <DynamicBigIcon className={clsx( styles.bigIcon, additionalClassName )}/>}
	</>)
	
}