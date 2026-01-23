import { Html, Text } from '@react-email/components';

export interface Email {
	form:{
		id_form: string;
		champ1: string;
		champ2: string;
		champ3: string;
		champ4: string;
        input1: string;
        input2: string;
        input3: string;
        input4: string;
	}
        
}

export function ContactEmailTemplate({form}:Email){

	return(<Html>
<Text>Contenu du formulaire {form.id_form}</Text>
<Text>{form.champ1}: {form.input1}</Text>
<Text>{form.champ2}: {form.input2}</Text>
<Text>{form.champ3}: {form.input3}</Text>
<Text>{form.champ4}: {form.input4}</Text>
	</Html>)
}