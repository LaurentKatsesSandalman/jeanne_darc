# Projet Jeanne d'Arc - Refonte Site Web - Contexte Complet

## 🎯 Vue d'ensemble du projet

**Objectif** : Refonte complète du site web de l'école privée Jeanne d'Arc (actuellement sous WordPress) vers une solution moderne Next.js.

**Contexte métier** :
- École privée payante → contraintes budgétaires strictes (solutions gratuites privilégiées)
- Utilisateurs principaux : visiteurs non authentifiés (parents, futurs élèves)
- Utilisateurs secondaires : personnel authentifié pour gestion de contenu (rare)
- Le site WordPress actuel reste en ligne sur `jeannedarc33.fr` jusqu'à bascule finale

**Contraintes importantes** :
- Budget : 0€/mois obligatoire
- Vercel Hobby interdit (écoles payantes exclues des conditions)
- Nécessité d'ISR pour pages publiques (performance)
- Modifications admin rares → délai acceptable pour voir les changements

---

## 🏗️ Stack Technique

### Frontend & Framework
- **Next.js 16.0.10** (App Router, Turbopack)
- **React Server Components** par défaut
- **TypeScript**
- Patterns :
  - Server Components par défaut
  - Client Components uniquement quand nécessaire (interactions, états)
  - Server Actions pour mutations (`"use server"`)

### Hébergement & Infra
- **Hébergement** : Netlify (plan gratuit)
  - URL temporaire : `https://jeannedarc33.netlify.app`
  - URL production : `https://refonte.jeannedarc33.fr`
- **Base de données** : Supabase (plan gratuit, 500MB)
  - PostgreSQL 17.6
  - **Transaction pooler** (port 6543) - CRITIQUE pour éviter limite connexions
  - Host : `aws-1-eu-central-1.pooler.supabase.com`
  - User : `postgres.anzunildaxtkoasuwywn`
  - Database : `postgres`
- **Authentification** : Clerk (mode Production)
  - Domaine configuré : `refonte.jeannedarc33.fr`
  - URLs : Frontend API, Account Portal, Email (CNAME configurés)

### Domaine & DNS
- **Registrar** : OVH
- **Domaine principal** : `jeannedarc33.fr` (pointe vers WordPress actuel)
- **Sous-domaine refonte** : `refonte.jeannedarc33.fr` (pointe vers Netlify)
- **Configuration DNS** :
  - `refonte` → CNAME → `jeannedarc33.netlify.app`
  - `clerk.refonte` → CNAME → `frontend-api.clerk.services`
  - `accounts.refonte` → CNAME → `accounts.clerk.services`
  - `clkmail.refonte` → CNAME → `mail.cusdru1tfxt0.clerk.services`
  - DKIM configurés pour emails

---

## 📊 Architecture Base de Données

### Migration OVH → Supabase
**Raison** : OVH Cloud Databases nécessite whitelist IP, incompatible avec Netlify (IPs dynamiques).

**Problèmes rencontrés et résolus** :
1. **Timeout initial** : Connexion créée au chargement du module → Solution : Lazy loading
2. **SSL Certificate** : `DEPTH_ZERO_SELF_SIGNED_CERT` → Solution : `ssl: { rejectUnauthorized: false }`
3. **Max connections** : Session pooler limite ~15 connexions → Solution : Transaction pooler (port 6543)

### Configuration db.ts (CRITIQUE)
```typescript
// lib/db.ts
import postgres from "postgres";

let sqlInstance = null;

function getSQL() {
    if (!sqlInstance) {
        sqlInstance = postgres({
            host: process.env.PG_HOST,
            port: Number(process.env.PG_PORT),
            username: process.env.PG_USER,
            password: process.env.PG_PASSWORD,
            database: process.env.PG_DB,
            ssl: { rejectUnauthorized: false }, // Supabase certificats
            max: 1, // IMPORTANT : serverless → 1 seule connexion
            idle_timeout: 20,
            connect_timeout: 30,
        });
    }
    return sqlInstance;
}

export const sql = getSQL();
```

**Points critiques** :
- ✅ Lazy loading (connexion créée à la première utilisation)
- ✅ `max: 1` pour environnement serverless
- ✅ Transaction pooler (6543) pas Session pooler (5432)
- ✅ SSL avec `rejectUnauthorized: false`

### Variables d'environnement BDD
```bash
PG_HOST=aws-1-eu-central-1.pooler.supabase.com
PG_PORT=6543  # Transaction pooler
PG_USER=postgres.anzunildaxtkoasuwywn
PG_PASSWORD=[mot_de_passe_supabase]
PG_DB=postgres
```

---

## 🔐 Authentification Clerk

### Configuration Production
- **Mode** : Production (pas Development)
- **Clés** : 
  - `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_live_xxxxx`
  - `CLERK_SECRET_KEY=sk_live_xxxxx`
- **Domaines autorisés** :
  - `https://refonte.jeannedarc33.fr`
  - `https://jeannedarc33.netlify.app`
  - `http://localhost:3000` (dev local)

### URLs configurées
- Sign-in URL : `/login`
- After sign-in : `/`
- Application URL : `https://refonte.jeannedarc33.fr`

### DNS Clerk (tous vérifiés ✅)
- Frontend API : `clerk.refonte.jeannedarc33.fr`
- Account Portal : `accounts.refonte.jeannedarc33.fr`
- Email SMTP : `clkmail.refonte.jeannedarc33.fr`
- DKIM 1 & 2 configurés
- SSL Certificates : Actifs

---

## 📁 Structure du Projet

```
jeannedarc/
├── app/
│   ├── layout.tsx                 # Layout principal (ClerkProvider, Header, Footer)
│   ├── page.tsx                   # Page d'accueil (ISR 1h)
│   ├── [..slug]/page.tsx          # Pages dynamiques (ISR 1h)
│   ├── gestion-pages/page.tsx     # Admin (force-dynamic)
│   ├── recherche/page.tsx
│   ├── login/[[...login]]/        # Clerk login
│   └── api/
│       └── test-supabase/route.ts # Route de test (à supprimer après debug)
├── components/
│   ├── Header/
│   │   └── HeaderServer.tsx       # Server Component (requêtes DB)
│   ├── Footer/
│   │   └── FooterServer.tsx       # Server Component (requêtes DB)
│   ├── Sections/                  # Composants de sections
│   ├── Contenus/                  # Composants de contenus
│   └── utils/
├── lib/
│   ├── db.ts                      # Configuration PostgreSQL (lazy loading)
│   ├── queries/
│   │   ├── contentCrudPage.ts     # "use server"
│   │   ├── contentCrudSection.ts  # "use server"
│   │   └── contentCrudContenu.ts  # "use server"
│   ├── actions/
│   │   ├── actionsPage.ts         # Server Actions + revalidatePath
│   │   ├── actionsSection.ts
│   │   └── actionsContenu.ts
│   └── schemas.ts                 # Interfaces TypeScript
├── netlify.toml                   # Config Netlify
├── next.config.js
└── .env                           # Variables locales (PAS committé)
```

---

## ⚙️ Configuration Netlify

### netlify.toml
```toml
[build]
  base = "jeannedarc"  # Sous-dossier dans le repo
  command = "pnpm run build"
  publish = ".next"

[[plugins]]
  package = "@netlify/plugin-nextjs"

[build.environment]
  NODE_VERSION = "22"
  PNPM_VERSION = "9"
```

### Variables d'environnement Netlify
```bash
# PostgreSQL Supabase
PG_HOST=aws-1-eu-central-1.pooler.supabase.com
PG_PORT=6543
PG_USER=postgres.anzunildaxtkoasuwywn
PG_PASSWORD=[password]
PG_DB=postgres

# Clerk Production
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_live_xxxxx
CLERK_SECRET_KEY=sk_live_xxxxx
NEXT_PUBLIC_CLERK_SIGN_IN_URL=/login
NEXT_PUBLIC_CLERK_SIGN_IN_FALLBACK_REDIRECT_URL=/
```

**IMPORTANT** : Toutes les variables doivent avoir :
- ✅ "All scopes" (Build + Functions + Post-processing)
- ✅ "All deploy contexts" (Production + Deploy Previews)

---

## 🚀 Stratégie de déploiement & ISR

### Pages publiques (ISR)
```typescript
// app/page.tsx, app/[...slug]/page.tsx
export const revalidate = 3600; // 1 heure

// PAS de "use server"
// PAS de export const dynamic = 'force-dynamic'
```

**Comportement** :
- Pages pré-générées au build
- Régénération toutes les heures
- Ultra-rapide pour visiteurs non authentifiés

### Pages admin (Dynamic)
```typescript
// app/gestion-pages/page.tsx
export const dynamic = 'force-dynamic';
export const revalidate = 0;

// PAS de "use server"
```

**Comportement** :
- Toujours générées à la demande
- Données en temps réel

### Server Actions (Revalidation immédiate)
```typescript
// lib/actions/actionsContenu.ts
"use server";

import { revalidatePath } from 'next/cache';

export async function updateContenuTexteAction(payload, id) {
  const result = await updateContenuTexteById(payload, id);
  
  // Régénère immédiatement les pages ISR concernées
  revalidatePath('/');
  revalidatePath('/[...slug]', 'page');
  
  return result;
}
```

**Résultat** :
- Admin fait une modification
- Pages ISR régénérées immédiatement
- Changements visibles en production après ~30 secondes

---

## 🛠️ Commandes Utiles

### Développement local
```bash
# Lancer le serveur de dev
pnpm run dev

# Build local (test avant déploiement)
pnpm run build

# Start production locale
pnpm start
```

### Base de données
```bash
# Export depuis local
pg_dump -h localhost -p 5432 -U sandalman jeanne_darc_db > backup.sql

# Export schéma + données séparément
pg_dump -h localhost -p 5432 -U sandalman jeanne_darc_db \
  --schema-only --no-owner --no-privileges > schema.sql
  
pg_dump -h localhost -p 5432 -U sandalman jeanne_darc_db \
  --data-only --column-inserts --no-owner --no-privileges > data.sql

# Test connexion Supabase
nslookup aws-1-eu-central-1.pooler.supabase.com
```

### DNS & Vérification
```bash
# Vérifier propagation DNS
nslookup refonte.jeannedarc33.fr
nslookup clerk.refonte.jeannedarc33.fr
nslookup -type=TXT subdomain-owner-verification.jeannedarc33.fr

# Test SSL
curl -I https://refonte.jeannedarc33.fr
```

### Git & Déploiement
```bash
# Déploiement (automatique sur push main)
git add .
git commit -m "Description"
git push

# Netlify redéploie automatiquement
# Surveiller sur: https://app.netlify.com
```

---

## 🐛 Troubleshooting

### Erreur : "Max clients reached"
**Cause** : Session pooler (port 5432) au lieu de Transaction pooler (6543)
**Solution** : Vérifier `PG_PORT=6543` dans Netlify

### Erreur : "ECONNRESET" ou timeout DB
**Cause** : Connexion créée trop tôt (au build)
**Solution** : Vérifier lazy loading dans `db.ts`

### Erreur : "self-signed certificate"
**Cause** : SSL strict avec Supabase
**Solution** : `ssl: { rejectUnauthorized: false }`

### Erreur : Clerk ne charge pas (ERR_SSL)
**Cause** : Certificats SSL Clerk pas encore émis
**Solution** : Attendre 10-30min après vérification DNS

### Pages ne se régénèrent pas après modification
**Cause** : `revalidatePath()` manquant dans Server Action
**Solution** : Ajouter `revalidatePath('/')` après mutations

### Build échoue avec "use server" dans page.tsx
**Cause** : Directive `"use server"` dans un fichier de page
**Solution** : Retirer. `"use server"` uniquement pour actions et queries.

---

## 📝 Conventions de Code

### Directives "use server" vs "use client"
- ✅ `"use server"` → Fichiers dans `lib/actions/` et `lib/queries/`
- ✅ `"use client"` → Composants avec interactivité (useState, onClick, etc.)
- ❌ JAMAIS `"use server"` dans `app/page.tsx` ou `app/layout.tsx`

### Server Components vs Client Components
- **Défaut** : Server Component
- **Client** uniquement si :
  - État React (`useState`, `useReducer`)
  - Hooks navigateur (`useEffect`, `useSearchParams`)
  - Event handlers (`onClick`, `onChange`)
  - Librairies client-only

### Nommage
- Server Components : `*Server.tsx` (ex: `HeaderServer.tsx`)
- Client Components : `*Client.tsx` (ex: `SectionTitreImageClient.tsx`)
- Server Actions : `actions*.ts` (ex: `actionsContenu.ts`)
- Queries : `contentCrud*.ts` (ex: `contentCrudPage.ts`)

### Try-Catch dans les pages
- ✅ Toujours wrapper les pages avec try-catch
- ✅ Logger les erreurs avec `console.error`
- ✅ Retourner UI d'erreur user-friendly

### Artifacts (Claude.ai)
- ❌ JAMAIS `localStorage` ou `sessionStorage` (non supporté)
- ✅ Utiliser React state (`useState`) à la place
- ✅ Ou stockage serveur via Server Actions

---

## 🔄 Workflow de Développement

### Développement local
1. Modifier le code en local
2. Tester sur `http://localhost:3000`
3. Base de données : Supabase production (même DB que prod)

### Mise en production
1. Commit + push sur `main`
2. Netlify build automatique (~2 min)
3. Vérifier logs de build sur Netlify
4. Tester sur `https://refonte.jeannedarc33.fr`

### Modifications de contenu (admin)
1. Connexion `/login` (Clerk)
2. Modification dans l'interface admin
3. Server Action appelée
4. `revalidatePath()` régénère les pages ISR
5. Changements visibles après ~30 sec

---

## 📋 Checklist Déploiement

### Avant premier déploiement
- [ ] Variables d'environnement configurées sur Netlify
- [ ] `netlify.toml` à la racine du projet
- [ ] Clés Clerk de **production** (pk_live_, sk_live_)
- [ ] DNS configurés (refonte + clerk CNAMEs)
- [ ] Supabase en Transaction pooler (port 6543)
- [ ] `db.ts` avec lazy loading et `max: 1`

### Après déploiement
- [ ] Site accessible sur refonte.jeannedarc33.fr
- [ ] `/login` fonctionne (Clerk)
- [ ] Pages publiques chargent (ISR)
- [ ] Admin peut se connecter
- [ ] Modifications admin visibles après revalidation

### Avant bascule finale (jeannedarc33.fr)
- [ ] Site testé pendant plusieurs jours
- [ ] Contenu migré et validé
- [ ] Backup WordPress fait
- [ ] DNS A record prêt à basculer
- [ ] Clerk configuré pour domaine principal

---

## 💰 Coûts

| Service | Plan | Coût |
|---------|------|------|
| Netlify | Free | 0€ |
| Supabase | Free (500MB) | 0€ |
| Clerk | Free | 0€ |
| OVH Domaine | Annuel | ~10€/an |
| **TOTAL** | | **~10€/an** |

---

## 🎯 Décisions Importantes & Rationales

### Pourquoi Supabase au lieu d'OVH ?
- OVH nécessite whitelist IP
- Netlify a des IPs dynamiques
- Supabase conçu pour serverless, gratuit, compatible Netlify

### Pourquoi Transaction pooler et pas Session pooler ?
- Session pooler limite ~15 connexions totales
- Netlify crée beaucoup de connexions simultanées
- Transaction pooler supporte ~200 connexions

### Pourquoi ISR avec revalidate 3600 ?
- Pages publiques très rapides (statiques)
- Modifications admin rares
- Compromis parfait performance/fraîcheur

### Pourquoi max: 1 connexion DB ?
- Environnement serverless (Netlify Functions)
- Chaque requête = nouvelle instance
- Pool inutile, 1 connexion suffit

### Pourquoi pas Vercel ?
- Vercel Hobby interdit pour écoles payantes
- Netlify Free autorisé, même features essentiels

---

## 🔮 Évolutions Futures Possibles

### Court terme
- [ ] Nettoyer console.log de debug
- [ ] Supprimer route `/api/test-supabase`
- [ ] Optimiser images (Next.js Image)
- [ ] Ajouter sitemap.xml

### Moyen terme
- [ ] Basculer domaine principal vers Netlify
- [ ] Analytics (Netlify ou Plausible gratuit)
- [ ] Contact form (Netlify Forms gratuit)
- [ ] Optimisation SEO avancée

### Long terme
- [ ] Row Level Security Supabase (si besoin sécurité++)
- [ ] Environnement staging séparé
- [ ] CI/CD avec tests automatisés
- [ ] Progressive Web App (PWA)

---

## 📞 Support & Ressources

### Documentation officielle
- [Next.js App Router](https://nextjs.org/docs)
- [Netlify Next.js](https://docs.netlify.com/frameworks/next-js/)
- [Supabase Docs](https://supabase.com/docs)
- [Clerk Docs](https://clerk.com/docs)

### Ressources spécifiques
- [Supabase Connection Pooling](https://supabase.com/docs/guides/database/connecting-to-postgres#connection-pooler)
- [Next.js ISR](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration)
- [Clerk Production Instances](https://clerk.com/docs/deployments/overview)

---

**Dernière mise à jour** : 20 janvier 2026
**Statut** : ✅ Production active sur refonte.jeannedarc33.fr