import { ContactEmailTemplate, Email } from '../../../components/ContactEmailTemplate/ContactEmailTemplate';
import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function POST(request:Request) {
const body:Email = await request.json()

  try {
    const { data, error } = await resend.emails.send({
      from: 'Formulaire JDA <formulaire@jeannedarc33.fr>',
    //   to: 'Direction <direction@jeannedarc33.fr>',
	   to: 'Laurent <laurent.durup@proton.me>',
      subject: `Contact via formulaire ${body.form.id_form}`,
      react: ContactEmailTemplate(body),
    });

    if (error) {
      return Response.json({ error }, { status: 500 });
    }

    return Response.json(data);
  } catch (error) {
    return Response.json({ error }, { status: 500 });
  }
}