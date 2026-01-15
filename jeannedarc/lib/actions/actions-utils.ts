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