import { z } from 'zod';
import type { JSONContent } from '@tiptap/core';

//.nullable() a été enlevé partout ; par defaut, les champs texte, y compris url, auront empty string comme valeur

export const UUIDSchema = z.uuid()
export type UUIDFormat = z.infer<typeof UUIDSchema>

// ===== UTILISATEUR =====
export const UtilisateurSchema = z.object({
  id_utilisateur: z.uuid(),
  email: z.email(),
  name: z.string().min(1),
  password: z.string().min(8),
  is_admin: z.boolean().default(false),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateUtilisateurSchema = UtilisateurSchema.omit({
  id_utilisateur: true,
  created_at: true,
  updated_at: true
});

export const UpdateUtilisateurSchema = CreateUtilisateurSchema.partial();

// ===== PAGE =====
export const PageSchema = z.object({
  id_page: z.uuid(),
  page_url: z.string().min(1),
  nom: z.string(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreatePageSchema = PageSchema.omit({
  id_page: true,
  created_at: true,
  updated_at: true
});

export const UpdatePageSchema = CreatePageSchema.partial();

// ===== SECTION =====
export const SectionSchema = z.object({
  id_section: z.uuid(),
  id_page_fk: z.uuid(),
  type: z.string().min(1),
  revert: z.boolean().default(false),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateSectionSchema = SectionSchema.omit({
  id_section: true,
  created_at: true,
  updated_at: true
});

export const UpdateSectionSchema = CreateSectionSchema.partial();

// ===== CONTENU_IMAGE =====
export const ContenuImageSchema = z.object({
  id_contenu_image: z.uuid(),
  id_section_fk: z.uuid(),
  image_url: z.url(),
  alt_text: z.string(),
  lien_vers: z.string(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuImageSchema = ContenuImageSchema.omit({
  id_contenu_image: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuImageSchema = CreateContenuImageSchema.partial();

// ===== CONTENU_TEXTE =====
export const ContenuTexteSchema = z.object({
  id_contenu_texte: z.uuid(),
  id_section_fk: z.uuid(),
  tiptap_content: z.custom<JSONContent>((val) => {
    return typeof val === 'object' && val !== null;
  }, { message: "Invalid Tiptap JSONContent format" }),
  created_at: z.date(),
  updated_at: z.date()
});

// WARNING
export const CreateContenuTexteSchema = z.object({
  id_section_fk: z.uuid(),
  tiptap_content: z.string()
});

export const UpdateContenuTexteSchema = z.object({
  tiptap_content: z.string()
});
// WARNING

// ===== CONTENU_CONTACT =====
export const ContenuContactSchema = z.object({
  id_contenu_contact: z.uuid(),
  id_section_fk: z.uuid(),
  titre: z.string().min(1),
  champ1: z.string().min(1),
  champ2: z.string().min(1),
  champ3: z.string().min(1),
  champ4: z.string().min(1),
  bouton: z.string().min(1),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuContactSchema = ContenuContactSchema.omit({
  id_contenu_contact: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuContactSchema = CreateContenuContactSchema.partial();

// ===== CONTENU_PDF =====
export const ContenuPdfSchema = z.object({
  id_contenu_pdf: z.uuid(),
  id_section_fk: z.uuid(),
  pdf_url: z.url(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuPdfSchema = ContenuPdfSchema.omit({
  id_contenu_pdf: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuPdfSchema = CreateContenuPdfSchema.partial();

// ===== CONTENU_TITRE =====
export const ContenuTitreSchema = z.object({
  id_contenu_titre: z.uuid(),
  id_section_fk: z.uuid(),
  is_mega: z.boolean().default(false),
  titre1: z.string(),
  titre2: z.string(),
  description: z.string(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuTitreSchema = ContenuTitreSchema.omit({
  id_contenu_titre: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuTitreSchema = CreateContenuTitreSchema.partial();

// ===== CONTENU_PAVE =====
export const ContenuPaveSchema = z.object({
  id_contenu_pave: z.uuid(),
  id_section_fk: z.uuid(),
  titre: z.string(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuPaveSchema = ContenuPaveSchema.omit({
  id_contenu_pave: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuPaveSchema = CreateContenuPaveSchema.partial();

// ===== CONTENU_BANDEAUBTN =====
export const ContenuBandeauBtnSchema = z.object({
  id_contenu_bandeaubtn: z.uuid(),
  id_section_fk: z.uuid(),
  icone_url: z.string(),
  titre: z.string(),
  description: z.string(),
  bouton: z.string().min(1),
  lien_vers: z.string().min(1),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuBandeauBtnSchema = ContenuBandeauBtnSchema.omit({
  id_contenu_bandeaubtn: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuBandeauBtnSchema = CreateContenuBandeauBtnSchema.partial();

// ===== CONTENU_HEADERBTN =====
export const ContenuHeaderBtnSchema = z.object({
  id_contenu_headerbtn: z.uuid(),
  id_section_fk: z.uuid(),
  position: z.number().int().min(0),
  bouton: z.string().min(1),
  lien_vers: z.string().min(1),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreateContenuHeaderBtnSchema = ContenuHeaderBtnSchema.omit({
  id_contenu_headerbtn: true,
  created_at: true,
  updated_at: true
});

export const UpdateContenuHeaderBtnSchema = CreateContenuHeaderBtnSchema.partial();

// ===== PAVE_BLOC =====
export const PaveBlocSchema = z.object({
  id_pave_bloc: z.uuid(),
  id_contenu_pave_fk: z.uuid(),
  position: z.number().int().min(0),
  icone_url: z.string(),
  soustitre: z.string(),
  description: z.string(),
  lien_vers: z.string(),
  created_at: z.date(),
  updated_at: z.date()
});

export const CreatePaveBlocSchema = PaveBlocSchema.omit({
  id_pave_bloc: true,
  created_at: true,
  updated_at: true
});

export const UpdatePaveBlocSchema = CreatePaveBlocSchema.partial();

// ===== TYPES INFÉRÉS =====
export type UtilisateurInterface = z.infer<typeof UtilisateurSchema>;
export type CreateUtilisateur = z.infer<typeof CreateUtilisateurSchema>;
export type UpdateUtilisateur = z.infer<typeof UpdateUtilisateurSchema>;
export type CreateUpdateUtilisateurResult = {success:true, data: UtilisateurInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type PageInterface  = z.infer<typeof PageSchema>;
export type CreatePage = z.infer<typeof CreatePageSchema>;
export type UpdatePage = z.infer<typeof UpdatePageSchema>;
export type CreateUpdatePageResult = {success:true, data: PageInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type SectionInterface  = z.infer<typeof SectionSchema>;
export type CreateSection = z.infer<typeof CreateSectionSchema>;
export type UpdateSection = z.infer<typeof UpdateSectionSchema>;
export type CreateUpdateSectionResult = {success:true, data: SectionInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type ContenuImageInterface  = z.infer<typeof ContenuImageSchema>;
export type CreateContenuImage = z.infer<typeof CreateContenuImageSchema>;
export type UpdateContenuImage = z.infer<typeof UpdateContenuImageSchema>;
export type CreateUpdateContenuImageResult = {success:true, data: ContenuImageInterface } | {success:false, error: string } | {success:false, errors: unknown };

// WARNING
export type ContenuTexteInterface  = z.infer<typeof ContenuTexteSchema>;
export type CreateContenuTexte = z.infer<typeof CreateContenuTexteSchema>;
export type UpdateContenuTexte = z.infer<typeof UpdateContenuTexteSchema>;
export type CreateUpdateContenuTexteResult = {success:true, data: ContenuTexteInterface } | {success:false, error: string } | {success:false, errors: unknown }; 
// WARNING

export type ContenuContactInterface  = z.infer<typeof ContenuContactSchema>;
export type CreateContenuContact = z.infer<typeof CreateContenuContactSchema>;
export type UpdateContenuContact = z.infer<typeof UpdateContenuContactSchema>;
export type CreateUpdateContenuContactResult = {success:true, data: ContenuContactInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type ContenuPdfInterface  = z.infer<typeof ContenuPdfSchema>;
export type CreateContenuPdf = z.infer<typeof CreateContenuPdfSchema>;
export type UpdateContenuPdf = z.infer<typeof UpdateContenuPdfSchema>;
export type CreateUpdateContenuPdfResult = {success:true, data: ContenuPdfInterface } | {success:false, error: string } | {success:false, errors: unknown };

export type ContenuTitreInterface  = z.infer<typeof ContenuTitreSchema>;
export type CreateContenuTitre = z.infer<typeof CreateContenuTitreSchema>;
export type UpdateContenuTitre = z.infer<typeof UpdateContenuTitreSchema>;
export type CreateUpdateContenuTitreResult = {success:true, data: ContenuTitreInterface } | {success:false, error: string } | {success:false, errors: unknown };

export type ContenuPaveInterface  = z.infer<typeof ContenuPaveSchema>;
export type CreateContenuPave = z.infer<typeof CreateContenuPaveSchema>;
export type UpdateContenuPave = z.infer<typeof UpdateContenuPaveSchema>;
export type CreateUpdateContenuPaveResult = {success:true, data: ContenuPaveInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type ContenuBandeauBtnInterface  = z.infer<typeof ContenuBandeauBtnSchema>;
export type CreateContenuBandeauBtn = z.infer<typeof CreateContenuBandeauBtnSchema>;
export type UpdateContenuBandeauBtn = z.infer<typeof UpdateContenuBandeauBtnSchema>;
export type CreateUpdateContenuBandeauBtnResult = {success:true, data: ContenuBandeauBtnInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type ContenuHeaderBtnInterface  = z.infer<typeof ContenuHeaderBtnSchema>;
export type CreateContenuHeaderBtn = z.infer<typeof CreateContenuHeaderBtnSchema>;
export type UpdateContenuHeaderBtn = z.infer<typeof UpdateContenuHeaderBtnSchema>;
export type CreateUpdateContenuHeaderBtnResult = {success:true, data: ContenuHeaderBtnInterface } | {success:false, error: string } | {success:false, errors: unknown }; 

export type PaveBlocInterface  = z.infer<typeof PaveBlocSchema>;
export type CreatePaveBloc = z.infer<typeof CreatePaveBlocSchema>;
export type UpdatePaveBloc = z.infer<typeof UpdatePaveBlocSchema>;
export type CreateUpdatePaveBlocResult = {success:true, data: PaveBlocInterface } | {success:false, error: string } | {success:false, errors: unknown };

export type ContenuTipTapInterface  = JSONContent;