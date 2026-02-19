# 🎓 École Jeanne d'Arc - Website Rebuild

> Modern Next.js 16 rebuild of a private elementary school website under strict zero additional budget constraints. Real production fullstack project with Server Components, ISR, and serverless architecture.

![Homepage Screenshot](./docs/screenshot-homepage.jpg)

[![Next.js](https://img.shields.io/badge/Next.js-16-black)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-blue)](https://www.typescriptlang.org/)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-green)](https://supabase.com/)
[![Netlify](https://img.shields.io/badge/Netlify-Free-00C7B7)](https://www.netlify.com/)

## 🎥 Admin Live Update Demo

![Admin workflow](docs/demo-quick.gif)

**Real-time admin workflow** - No speed-up, actual production performance:
- ✅ TipTap rich text editing with live save (Server Actions)
- ✅ Image upload to Netlify Blobs
- ✅ ISR revalidation with `revalidatePath()` (a few seconds)
- ✅ Changes instantly visible to public visitors

*Authenticated via Clerk - 30-second complete edit-to-publish cycle*

---

## 📖 About

Complete technical modernization of École Jeanne d'Arc's website (Le Bouscat, France), migrating from a legacy WordPress installation to a modern Next.js application.

**Live URLs:**
- Previous production: `refonte.jeannedarc33.fr` (temporary subdomain)
- Current migration: `jeannedarc33.fr` (replaces WordPress)

**Context:**
- Private elementary school with strict zero additional budget constraint (OVH domain already existing)
- Real production environment serving current and prospective parents, and enabling edition for school Director
- Built in full autonomy during fullstack development internship
- Design intentionally kept similar to existing WordPress site (requirement from school Director)

**Key Constraint:** All infrastructure must remain on free tiers permanently (no paid upgrades allowed).

---

## ⚡ Tech Stack

**Frontend & Framework**
- Next.js 16 (App Router, Server Components)
- TypeScript

**Database & Authentication**
- Supabase (PostgreSQL 17, free tier 500MB)
- Clerk (production mode authentication): SOC 2 security, GDPR compliant, scalabilité (10k users), time-to-market
- Direct PostgreSQL connections via `postgres.js`

**Hosting & Infrastructure**
- Netlify (free tier hosting)
- Netlify Blobs (media storage)
- Netlify Serverless Functions

**Content Management**
- TipTap rich text editor
- Custom admin interface with dynamic section mapping

---

## 🏗️ Key Technical Decisions

### 1. ISR with 24-hour revalidation

**Challenge:** Balance performance for public visitors, content freshness for admin updates, and Netlify costs for building new pages (credit consumption).

**Solution:** Incremental Static Regeneration (ISR) with 24-hour revalidation
- Public pages pre-generated at build time for maximum performance
- Manual revalidation via Server Actions after admin edits (`revalidatePath()`)
- Automatic regeneration every 24 hours (safety)

**Result:** Ultra-fast public pages (static delivery) with acceptable content freshness for a school website where updates are infrequent.

---

### 2. Server-side security architecture

**Challenge:** Secure the application without relying on traditional Supabase Row Level Security.

**Solution:** Server-side security model
- PostgREST API disabled (no direct client access to database)
- All database queries handled through Server Components and Server Actions
- Authentication and authorization managed at application level with Clerk
- Protected routes via Next.js middleware

**Result:** Database accessible only from server-side code. Row Level Security not required since client never directly queries the database, maintaining security while simplifying the architecture.

---

### 3. Zero-cost hosting strategy

**Challenge:** Find zero-cost hosting compatible with:
- Private school business model (Vercel Hobby excluded per TOS)
- Serverless architecture requirements
- Dynamic IP addresses (OVH whitelist incompatible)

**Solution:** Netlify Free tier
- Next.js plugin with ISR support
- Serverless Functions for API routes
- Compatible with educational institution usage
- 300 build credits/month for production workflow

**Result:** Sustainable zero-cost hosting meeting all technical requirements. Daily monitoring of build credits and serverless function usage ensures the free tier remains viable for production.

---

## ✨ Features

- **Dynamic Content Management**: Custom admin interface on each page for sections management and content
- **Accessibility**: WCAG compliance with tab navigation, ARIA attributes, focus management
- **SEO Optimized**: Dynamic metadata, sitemaps, canonical URLs, JSON-LD structured data
- **Responsive Design**: Mobile and Desktop tailored experiences
- **Rich Text Editing**: TipTap editor with custom extensions
- **Media Management**: Netlify Blobs integration for images and documents

---

## 🚀 Architecture Highlights

**Component Strategy:**
- Server Components by default for automatic performance optimization
- Client Components only when necessary (interactivity, hooks like useState)
- Server Actions for all mutations with immediate revalidation

**Page Generation:**
- ISR for public pages (`revalidate: 86400`)
- Instant cache invalidation after content updates

---

## 🎓 What I Learned

**Technical Skills:**
- ISR internals and revalidation strategies
- Server Components vs Client Components trade-offs
- Serverless cost optimization (build credits, function duration)
- Production authentication with Clerk

**Business Skills:**
- Managing strict budget constraints
- Monitoring production costs in real-time

---

## 📄 License

MIT License

---

**Built by Laurent Durup** | [LinkedIn](https://www.linkedin.com/in/laurent-durup/)
