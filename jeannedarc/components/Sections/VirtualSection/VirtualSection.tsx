import { SectionInterface } from "@/lib/schemas";
import { SectionTexteTexteServer } from "@/components/Sections/SectionTexteTexte/SectionTexteTexteServer";
import { SectionImageTexteServer } from "@/components/Sections/SectionImageTexte/SectionImageTexteServer";
import { SectionTexteServer } from "@/components/Sections/SectionTexte/SectionTexteServer";
import { SectionTitreServer } from "@/components/Sections/SectionTitre/SectionTitreServer";

interface VirtualSectionProps {
	section: SectionInterface;
	isAuth: boolean;
}

export function VirtualSection({ section, isAuth }: VirtualSectionProps) {
	switch (section.type) {
		case "Titre":
			return <SectionTitreServer isAuth={isAuth} section={section} />;
		case "Texte":
			return <SectionTexteServer isAuth={isAuth} section={section} />;
		case "TexteTexte":
			return (
				<SectionTexteTexteServer isAuth={isAuth} section={section} />
			);
		case "ImageTexte":
			return (
				<SectionImageTexteServer isAuth={isAuth} section={section} />
			);
		default:
			console.warn(`Type de section inconnu: ${section.type}`);
			return null;
	}
}