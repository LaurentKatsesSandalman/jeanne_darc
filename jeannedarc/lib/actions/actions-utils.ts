/* A quoi ressemble un json tip-tap ?
grand "tree" avec pleins de noeuds, dont des noeuds comme ceci :
{
  "type": "paragraph",
  "content": [
    { "type": "text", "text": "Bonjour" },
    { "type": "text", "text": " le monde" }
  ]
le json est de type JSONContent, ainsi que chacun de ses "sous-noeuds"
}*/

import { ContenuTipTapInterface } from "../schemas"

export function makePlaintext (stringArray:string[], tiptap_content?:ContenuTipTapInterface): string {
let text = ""

for (const value of stringArray){
	if(value){ text += " "+value}
}
if (tiptap_content){text += " " + tiptapJsonToPlainText(tiptap_content)}

return text
}

function tiptapJsonToPlainText(node: ContenuTipTapInterface): string {
	let plainText = ""

	function recurse (n: ContenuTipTapInterface|undefined){
		if(!n) {return;}

		if (typeof n.text === "string"){plainText += " "+n.text}

		// pourrait être un else if
		if(Array.isArray(n.content)){
			n.content.forEach(recurse);
		}
	}

	recurse(node)
	return plainText
}

export function textExtractor(fullText:string, search:string,maxBefore:number,maxAfter:number):string{
	//comme textExtractor n'est appelé que par searchIndexAction, il n'y a pas pour l'instant de vérification des types des paramètres fulltext et search
	const searchArray = search.split(" ").sort((a,b)=>b.length - a.length)
	const checkedMaxBefore = (typeof maxBefore === "number" && maxBefore>0)?maxBefore:120;
	const checkedMaxAfter = (typeof maxAfter === "number" && maxAfter>0)?maxAfter:120;
	let searchIndex = 0

	for(const word of searchArray){
		const index = fullText.toLowerCase().indexOf(word.toLowerCase())
		if(index !== -1){searchIndex = index; break;}
	}

	const beforeIndex = (searchIndex-checkedMaxBefore)<0?0:searchIndex-checkedMaxBefore
 const afterIndex = searchIndex+checkedMaxAfter


	const prefix = beforeIndex > 0 ? '...' : '';
const suffix = afterIndex < fullText.length ? '...' : '';
return prefix + fullText.slice(beforeIndex, afterIndex) + suffix;
}