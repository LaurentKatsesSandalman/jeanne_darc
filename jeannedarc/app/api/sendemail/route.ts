import { ContactEmailTemplate, Email } from '../../../components/ContactEmailTemplate/ContactEmailTemplate';
import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

// Rate limiter en mémoire (au niveau du module, avant la fonction POST)
const rateLimiter = new Map<string, { count: number; resetTime: number }>();

function checkRateLimit(ip: string): boolean {
    const now = Date.now();
    const limit = rateLimiter.get(ip);
    
    if (!limit || now > limit.resetTime) {
        rateLimiter.set(ip, { count: 1, resetTime: now + 60 * 60 * 1000 });
        return true;
    }
    
    if (limit.count >= 2) {
        return false;
    }
    
    limit.count++;
    return true;
}

export async function POST(request:Request) {
 // RATE LIMITING ICI, EN PREMIER
    const ip = request.headers.get('x-forwarded-for') || 'unknown';
    
    if (!checkRateLimit(ip)) {
        return Response.json(
            { error: 'Trop de messages envoyés. Veuillez réessayer plus tard.' },
            { status: 429 }
        );
    }



const body:Email = await request.json()
if (body.form.verif) {
        // Bot détecté, on retourne succès sans envoyer
        return Response.json({ success: true });
    }

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