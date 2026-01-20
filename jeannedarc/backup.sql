--
-- PostgreSQL database dump
--

\restrict UUFMb7iZ6bUqoEPne1AGhrOX6QIlWrd0uCIHSppuwv6lVuvFGkmTlYwdcaNABOu

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: sandalman
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO sandalman;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: sandalman
--

COMMENT ON SCHEMA public IS '';


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: sandalman
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO sandalman;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contenu_bandeaubtn; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_bandeaubtn (
    id_contenu_bandeaubtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    icone text DEFAULT ''::text NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_bandeaubtn OWNER TO sandalman;

--
-- Name: contenu_contact; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_contact (
    id_contenu_contact uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    champ1 text DEFAULT ''::text NOT NULL,
    champ2 text DEFAULT ''::text NOT NULL,
    champ3 text DEFAULT ''::text NOT NULL,
    champ4 text DEFAULT ''::text NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_contact OWNER TO sandalman;

--
-- Name: contenu_headerbtn; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_headerbtn (
    id_contenu_headerbtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    "position" smallint NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id_page_fk uuid NOT NULL
);


ALTER TABLE public.contenu_headerbtn OWNER TO sandalman;

--
-- Name: contenu_image; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_image (
    id_contenu_image uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    image_url text DEFAULT ''::text NOT NULL,
    alt_text text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_image OWNER TO sandalman;

--
-- Name: contenu_pave; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_pave (
    id_contenu_pave uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_pave OWNER TO sandalman;

--
-- Name: contenu_pdf; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_pdf (
    id_contenu_pdf uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    pdf_url text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    pdf_titre text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.contenu_pdf OWNER TO sandalman;

--
-- Name: contenu_solobtn; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_solobtn (
    id_contenu_solobtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_solobtn OWNER TO sandalman;

--
-- Name: contenu_texte; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_texte (
    id_contenu_texte uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    tiptap_content jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_texte OWNER TO sandalman;

--
-- Name: contenu_titre; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.contenu_titre (
    id_contenu_titre uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    is_mega boolean DEFAULT false NOT NULL,
    titre1 text DEFAULT ''::text NOT NULL,
    titre2 text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contenu_titre OWNER TO sandalman;

--
-- Name: page; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.page (
    id_page uuid DEFAULT gen_random_uuid() NOT NULL,
    page_url text NOT NULL,
    nom text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.page OWNER TO sandalman;

--
-- Name: pave_bloc; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.pave_bloc (
    id_pave_bloc uuid DEFAULT gen_random_uuid() NOT NULL,
    id_contenu_pave_fk uuid NOT NULL,
    icone text DEFAULT ''::text NOT NULL,
    soustitre text DEFAULT ''::text NOT NULL,
    description1 text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    description2 text DEFAULT ''::text NOT NULL,
    description3 text DEFAULT ''::text NOT NULL,
    description4 text DEFAULT ''::text NOT NULL,
    description5 text DEFAULT ''::text NOT NULL,
    description6 text DEFAULT ''::text NOT NULL,
    description7 text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.pave_bloc OWNER TO sandalman;

--
-- Name: section; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.section (
    id_section uuid DEFAULT gen_random_uuid() NOT NULL,
    id_page_fk uuid NOT NULL,
    type text NOT NULL,
    revert boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.section OWNER TO sandalman;

--
-- Name: text_index; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.text_index (
    id_text_index uuid DEFAULT gen_random_uuid() NOT NULL,
    id_page_fk uuid NOT NULL,
    ref_table text NOT NULL,
    ref_id uuid NOT NULL,
    content_plaintext text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.text_index OWNER TO sandalman;

--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: sandalman
--

CREATE TABLE public.utilisateur (
    id_utilisateur uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO sandalman;

--
-- Data for Name: contenu_bandeaubtn; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_bandeaubtn (id_contenu_bandeaubtn, id_section_fk, icone, titre, description, bouton, lien_vers, created_at, updated_at) FROM stdin;
a55f1030-e11f-4545-966f-d1dac1e726e0	24927bed-1f90-4a4b-995f-9c7a548e8fa2	BigCalendarBigIcon	pré-inscription	Demande de Pré-Inscription de votre enfant à l’école JEANNE D’ARC	pré-inscriptions	https://preinscriptions.ecoledirecte.com/?RNE=0331922K&ETAB=EC	2026-01-12 15:40:23.356019+01	2026-01-12 15:41:15.74017+01
cce2a1e0-463e-403e-89ac-35ec8e2d0795	df2360f2-49bc-46c9-a7b5-9dce3de86043	AAAEmpty2BigIcon			 LIEN DE PRÉ-INSCRIPTION	https://preinscriptions.ecoledirecte.com/?RNE=0331922K&ETAB=EC	2026-01-14 10:41:39.310957+01	2026-01-14 10:42:06.630882+01
b1615ac4-2cda-43cd-965a-93dfe9b7ae56	cad4f442-ee3d-48a1-949c-e71800b3beba	BigDiplomaBigIcon		Accéder aux notes, aux devoirs et à toutes les informations de votre enfant à l’école	école directe	https://www.ecoledirecte.com/login	2026-01-14 10:43:38.39379+01	2026-01-14 10:53:57.790452+01
cb24a194-f802-4364-828a-6e38ae3ca88e	640a25da-7d94-4216-97a9-806118e14fbc	AAAEmpty2BigIcon	Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023		commander la blouse	https://www.letablierbobine.fr/produits?school=jdalebouscat#product-list%0Acode%20d'acc%C3%A8s%20:%20jdalebouscat	2026-01-09 08:51:47.757887+01	2026-01-14 10:55:56.644659+01
371922a6-19cf-4d07-8fd7-c4383b873e75	1fd4931c-5d7e-40c3-b0a6-409b099dd5aa	AAAEmpty2BigIcon			Commander la blouse	https://www.letablierbobine.fr/produits?school=jdalebouscat#product-list%0Acode%20d'acc%C3%A8s%20:%20jdalebouscat	2026-01-14 10:58:29.826793+01	2026-01-14 10:58:56.380053+01
\.


--
-- Data for Name: contenu_contact; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_contact (id_contenu_contact, id_section_fk, titre, champ1, champ2, champ3, champ4, bouton, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contenu_headerbtn; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_headerbtn (id_contenu_headerbtn, id_section_fk, "position", bouton, lien_vers, created_at, updated_at, id_page_fk) FROM stdin;
11b17fd2-e045-4e39-8315-db8fa7319c6d	6c86d086-0014-4b2c-ad71-573706d345e1	1	projets	/projets	2026-01-05 11:08:14.905232+01	2026-01-06 11:21:48.211512+01	8cecaa91-a539-45fe-8151-a8650934ee7a
89dc08e8-6342-435e-ab91-3ba0d1958d2e	6c86d086-0014-4b2c-ad71-573706d345e1	3	projet pédagogique	/projets/projet-pedagogique	2026-01-05 11:08:23.150542+01	2026-01-06 11:21:48.211512+01	e11935b9-f19d-41ee-a061-d3f9bd26afde
30d95638-16cc-4c9a-8b06-15b6023e91c7	6c86d086-0014-4b2c-ad71-573706d345e1	4	projet pastoral	/projets/projet-pastoral	2026-01-05 11:08:27.614928+01	2026-01-06 11:21:48.211512+01	ccd9338f-0f5c-42a2-9b3e-465645c80ff2
cc1ee6cc-1292-46c1-a7f2-6bfdbc26f244	05ee1e16-c142-42b5-b459-afcc593e3393	1	pré-inscriptions	/pre-inscriptions	2026-01-05 11:08:31.520127+01	2026-01-06 11:21:48.211512+01	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e
b8ca932b-df3c-4e71-a5cb-a6631e37cf00	bed09afd-02b1-4036-87a7-8a95c7918a28	1	contact	/contact	2026-01-05 11:08:42.881036+01	2026-01-06 11:21:48.211512+01	64d857cc-b5f2-4b09-9024-46789bfef3ea
a438debb-0561-4fdc-82de-cdcd4e524e6a	516ca4e0-1661-4991-ab84-b5d5b3b52a27	1	plus	/plus	2026-01-05 11:08:36.362199+01	2026-01-06 11:21:48.211512+01	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3
217eb06c-a158-4b80-abc7-e428e5517e2a	516ca4e0-1661-4991-ab84-b5d5b3b52a27	2	école directe	/plus/ecole-directe	2026-01-05 11:08:39.902771+01	2026-01-06 11:21:48.211512+01	295029ce-e0e9-475a-ae67-574139fa31b2
1a06712b-a0a6-47a2-a8c6-1b0aa7a6e37d	516ca4e0-1661-4991-ab84-b5d5b3b52a27	3	règlement intérieur	/plus/reglement	2026-01-05 14:41:34.553345+01	2026-01-06 11:21:48.211512+01	6446302e-8285-44c0-95df-b49cf8b080bb
c86d4854-54d1-4a6c-b902-b88e29f6caae	516ca4e0-1661-4991-ab84-b5d5b3b52a27	4	Blouses JDA	/plus/blouses	2026-01-05 14:42:52.308789+01	2026-01-06 11:21:48.211512+01	c336b0b8-e554-494d-8837-2f8e2bf4bc85
ccac5f6a-771f-4f73-a48d-76dd1f164f15	516ca4e0-1661-4991-ab84-b5d5b3b52a27	5	Tarifs	/plus/tarifs	2026-01-05 14:43:35.841314+01	2026-01-06 11:21:48.211512+01	c740cf55-6c49-4919-b2d8-e1f6e74e0230
7a09d21d-0a0c-402d-8959-1bc4eaa5591d	516ca4e0-1661-4991-ab84-b5d5b3b52a27	6	OGEC	/plus/ogec	2026-01-05 14:44:17.837002+01	2026-01-06 11:21:48.211512+01	f7c70f0c-23ce-4736-9328-15237670045c
e439a303-2919-4dd9-a881-9dc3f2bf8083	6c86d086-0014-4b2c-ad71-573706d345e1	2	projet éducatif	/projets/projet-educatif	2026-01-05 11:08:19.324654+01	2026-01-06 11:21:48.211512+01	74d676f1-767e-4350-8a41-9c1c0999faf7
8860014a-6584-42fb-ae7b-4bd67da91603	8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	1	accueil	/	2026-01-05 11:08:10.883783+01	2026-01-06 11:24:06.596211+01	8166954f-eb2d-48ed-a915-e207ae1406e4
8909eca5-7749-4f52-ba3c-9c908e84a67f	8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	2	Histoire de l'école	/presentation-histoire	2026-01-12 14:34:21.022578+01	2026-01-12 14:34:21.022578+01	d3d52cd8-5458-44a7-bf81-3f4986377e6a
\.


--
-- Data for Name: contenu_image; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_image (id_contenu_image, id_section_fk, image_url, alt_text, lien_vers, created_at, updated_at) FROM stdin;
71c9a03b-a74d-41bf-9fb1-d94eabad38e0	610a236a-6c92-46e1-b281-41060ac503e8	https://www.jeannedarc33.fr/wp-content/uploads/2023/04/Projet-Pedagogique-et-Pastoral-ENCADRE-1536x1536.png	Schéma projet pédagogique et pastoral		2025-12-17 13:02:16.116947+01	2025-12-17 14:56:07.703505+01
5abd390b-4136-42ee-a99e-b0ac5964ade2	4e3b39ec-7f51-4444-a2ec-b318c9522e0e	https://www.jeannedarc33.fr/wp-content/uploads/2024/08/IMG_3024-2048x1536.jpeg	la crèche de Noël		2026-01-07 17:12:05.61063+01	2026-01-07 17:18:54.226563+01
8bc01f96-d279-41f2-bc5a-9034ed6c720c	30c8a13e-ac22-4c2d-a150-dca3093f3661	https://www.jeannedarc33.fr/wp-content/uploads/2025/11/pastorale.png	schéma du projet pastoral		2026-01-07 17:19:13.474066+01	2026-01-07 17:19:50.471993+01
1409095f-f110-473a-aaa1-47deef6bbf0d	121ace6e-3bba-49ce-a70f-ff02bac25060	https://www.jeannedarc33.fr/wp-content/uploads/2023/03/IMG_1210-1536x2048.jpg	Fronton de l'institution Jeanne d'Arc		2026-01-12 15:40:06.775833+01	2026-01-12 15:43:02.932883+01
0f3b344e-4bdf-4374-a669-a852d2aa95f9	dad61c44-7a22-4307-8e63-cbe1a7847346	https://www.jeannedarc33.fr/wp-content/uploads/2023/01/Cour_de_recreation3.jpg	Cour de récréation, illustration		2026-01-13 14:22:29.804974+01	2026-01-13 14:23:00.107937+01
2eb6341f-1456-4ccb-8609-e3f85aef1d29	f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	https://www.jeannedarc33.fr/wp-content/uploads/2023/04/ESTRAMPES.png	Photo de Madame Estrampe		2026-01-14 10:16:38.996071+01	2026-01-14 10:17:28.443307+01
ba19954f-6152-40c7-9e17-57a2648cc5ba	8a1ed75d-0ad1-4339-9cbe-45fe3418009a	https://www.jeannedarc33.fr/wp-content/uploads/2025/11/EQUIPE-scaled.jpg	Equipe de l'école privée Jeanne d'Arc - Le Bouscat - année scolaire 2025/2026		2026-01-14 10:25:33.92772+01	2026-01-14 10:26:43.948887+01
ce425a7e-c10e-4416-a70d-326c44ae2f82	a67777de-6746-4910-823f-ec604fa6363a	https://www.jeannedarc33.fr/wp-content/uploads/2023/06/image.png	Schéma en pétales : pétale 1 ( intériorité, liberté, fraternité, hospitalité), pétale 2 (responsabilité, curiosité, estime de soi), pétale 3 (accueil, bienveillance, partage, communauté)		2026-01-14 10:32:36.994238+01	2026-01-14 10:34:50.28165+01
77faf54b-5d6c-43c6-9537-f0eb2f03fe61	cf221b63-3868-42c3-ac1a-ee9e456eadef	http://www.image-heberg.fr/files/1765794470531451060.png			2026-01-14 11:01:34.59434+01	2026-01-14 11:01:34.59434+01
\.


--
-- Data for Name: contenu_pave; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_pave (id_contenu_pave, id_section_fk, titre, created_at, updated_at) FROM stdin;
33da439e-f856-4562-ab64-1db067c416a1	fcb5856f-3ac2-4d04-becb-081b588b0464	LE PROJET D’ÉTABLISSEMENT	2026-01-13 14:23:47.373832+01	2026-01-13 14:24:10.206069+01
fd346e21-5871-4d15-a152-53f3c8671fc1	3ec7ccdc-46fc-426d-8cbb-92d38d59c10e		2026-01-13 12:21:16.8551+01	2026-01-13 15:50:37.128968+01
b0479b65-e5cf-4de2-bb5c-42c234df8342	d789a75b-2f50-418a-b4a6-00e77dfe6581		2026-01-13 16:51:35.676811+01	2026-01-13 16:51:35.676811+01
dc6fc558-8f03-40e6-8e70-0e5e28a3198d	2190e0a1-cf08-4f3c-98a8-002c1e4ad2a1		2026-01-14 09:00:20.589213+01	2026-01-14 09:00:20.589213+01
\.


--
-- Data for Name: contenu_pdf; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_pdf (id_contenu_pdf, id_section_fk, pdf_url, created_at, updated_at, pdf_titre) FROM stdin;
e943d4b8-6444-4705-be99-1907d91bf5ac	4ac5f0aa-48d0-4ee1-b342-2c31801f7dc4	https://www.jeannedarc33.fr/wp-content/uploads/2025/11/REGLEMENT_interieur_JDA_2026_2025_Nouveau.pdf#zoom=86	2026-01-07 17:31:34.487794+01	2026-01-08 10:47:40.887939+01	Règlement intérieur
7985ea3e-37a6-4516-8f11-83aceddc17d6	62f8c8a7-f586-4a6b-bece-806cb37675a7	https://www.jeannedarc33.fr/wp-content/uploads/2023/08/Circulaire-Jeanne-dArc-Le-Bouscat-2023-1.pdf	2026-01-14 10:57:08.045433+01	2026-01-14 10:58:16.527992+01	Commande de la blouse Jeanne d'Arc
11c1c10c-db3a-4f63-85c9-812d811d7ea8	602196fd-53b4-4752-b05a-cc569b22b61a	https://www.jeannedarc33.fr/wp-content/uploads/2025/11/TARIFS_2025-2026.pdf	2026-01-14 10:59:55.91033+01	2026-01-14 11:00:23.998671+01	TARIFS 2025-2026
\.


--
-- Data for Name: contenu_solobtn; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_solobtn (id_contenu_solobtn, id_section_fk, bouton, lien_vers, created_at, updated_at) FROM stdin;
2f196cfe-4e52-4af7-a829-03846f3151fc	121ace6e-3bba-49ce-a70f-ff02bac25060	histoire de l'école	/presentation-histoire	2026-01-12 15:45:51.445687+01	2026-01-12 15:52:30.801513+01
e72ad051-52db-4210-af60-5dc7759ba3da	121ace6e-3bba-49ce-a70f-ff02bac25060	voir le projet d'établissement	/projets	2026-01-12 15:52:37.722832+01	2026-01-12 15:52:56.504612+01
243fa9b0-f121-45f8-ab2f-07eb966b9e6d	121ace6e-3bba-49ce-a70f-ff02bac25060	nous contacter	/contact	2026-01-13 16:50:41.686777+01	2026-01-13 16:50:57.642558+01
\.


--
-- Data for Name: contenu_texte; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_texte (id_contenu_texte, id_section_fk, tiptap_content, created_at, updated_at) FROM stdin;
fec83639-9b1a-4480-929e-2c2b01cb7c52	610a236a-6c92-46e1-b281-41060ac503e8	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "S’émerveiller d’apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Un climat de classe et d’école serein pour bien apprendre et bien vivre ensemble", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La Classe-qualité : réflexion et attention afin de répondre aux besoins des élèves pour bien apprendre. Donner la possibilité à nos élèves de restituer et d’offrir : lors des spectacles, de mises en scène, de chorale…", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "S’engager activement dans ses apprentissages", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Accompagner nos élèves à développer le questionnement et la réflexion", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Travailler ensemble", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Se mettre en projet", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Apprendre à apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Les apports des neurosciences et de la gestion mentale pour mieux apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La place du statut de l’erreur", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La cohérence pédagogique", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2025-12-17 13:02:11.532495+01	2025-12-17 16:37:35.449017+01
df61c9a8-ea5c-4a72-9724-05b8875fdee2	2e5b0548-c923-45c8-80b5-6e045a4877f5	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": "center"}, "content": [{"text": "L’école met au centre de la vie scolaire 6 piliers.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La culture littéraire : « Silence On Lit », mini-médiathèque, les incorruptibles, participation au salon du livre du Bouscat.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Le sport et l’éducation sportive : utilisation des installations sportives et animateurs sportifs de la ville et de l’école, animations sportives sur la pause méridienne.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La culture numérique : Toutes les classes de l’école est équipée de VPI, et d’une flotte d’IPAD qui servent de support aux apprentissages des élèves.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’anglais : des cours d’anglais et des « English Games » sont proposés à tous les élèves (de la Petite Section au CM2) par une personne native anglophone.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Un projet d’école annuel : chaque année, un thème d’année est choisi en lien avec un mode différent d’intelligence.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Les activités culturelles : Tout au long de l’année, les élèves participent à des spectacles, des expositions… , en lien et en illustration avec les apprentissages.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2025-12-17 13:02:11.532495+01	2025-12-17 13:57:03.96492+01
b7895663-f2b4-49c5-bd35-b0381032d3b5	4e3b39ec-7f51-4444-a2ec-b318c9522e0e	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Vivre en Frères :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(246, 174, 59)"}}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Écoute, accueil, convivialité : rencontres proposées aux familles pour mieux se connaître et échanger.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Service : mise à disposition des talents des uns et des autres pour l’école et l’entraide.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Actions solidaires.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Pour découvrir la parole de Dieu :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(246, 174, 59)"}}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Éveil à la foi pour les plus jeunes et catéchèse pour les autres", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "T", "type": "text"}, {"text": "emps pastoraux et communautaires : 3 samedis dans l’année", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Temps spirituels, prières, célébrations", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-07 17:12:05.683094+01	2026-01-07 17:15:13.227755+01
1b3cf84e-e381-4009-b3c9-367f546ab1eb	f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école Jeanne d’Arc est officiellement créée le 29 août 1902.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "Le premier octobre 1902, Madame Estrampes ouvre l’école sur la propriété que possède son mari depuis 1884 au 45 rue Francis de Pressensé. École privée de filles, certes, où les registres portent parfois les noms d’Albert, Auguste, Paul… !", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école se développe et les directrices se succèdent, Pauline Estrampes (1904), Angèle Lacrampe (1960) …. Melle Tricotet (1968).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école est menacée de fermeture en 1968, quand Françoise Clion en prend la direction. Il faut faire ses preuves, patiemment, consciencieusement. Les garçons sont admis officiellement. Malgré les menaces qui pèsent sur l’enseignement libre, l’école résiste, sa réputation se répand.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "Un don généreux d’une ancienne maman de l’école permettra de rembourser un emprunt fait pour les travaux.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "En 1985, l’école signe un contrat d’association avec l’État. L’école se développe, dédouble des classes, diversifie ses activités pédagogiques et approfondit le travail d’équipe.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "En mars 2008, elle obtient de l’Inspection Académique l’ouverture d’une classe maternelle pour la rentrée 2008-2009.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’OGEC (organisme de gestion de l’établissement) décide alors d’un projet d’extension et de rénovation en 2009.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 10:16:39.086258+01	2026-01-14 10:20:24.642354+01
b7797350-ac31-496a-bdb5-1a2bb9383209	fbe7a9d9-a622-437b-976b-b2082ead2539	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Les dates clés :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "29 août 1902 : Création de l’école Jeanne d’arc, école privée de filles.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1er octobre 1902 : Ouverture de l’école : 2 classes – Mme Estrampes, directrice, sa fille Pauline est adjointe.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1er octobre 1904 : Pauline Estrampes devient directrice, Mme Estrampes, mère, reste adjointe.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1916 : 3 classes.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1957 : 7 classes.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "J", "type": "text"}, {"text": "usqu’en 1960, internat à l’école.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1960 : Angèle Lacrampe (adjointe depuis 1928) devient directrice puis MlleTricotet jusqu’en 1968 (classe de maternelle au collège 6/5ᵉ et 4/3ᵉ).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1968 : Fermeture du collège – Arrivée de Mme Clion à la direction.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1985 : Obtention du contrat d’association avec l’Etat.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "2004 : Nomination de Mme Brigitte Dejean, à la direction de l’établissement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "2019 : Nomination de Mme Albane Motais de Narbonne, actuel chef d’établissement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 10:20:39.561741+01	2026-01-14 10:24:27.877146+01
522a90bd-9621-46ac-886c-de5e58d34b3d	23b44287-025a-4bf2-befa-c36a9dc914a3	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": "center"}, "content": [{"text": "Aujourd’hui", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}, "content": [{"text": "Actuellement, nous accueillons 215 élèves de la petite section au CM2 répartis en 8 classes :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "3 classes maternelles (accueil dès 3 ans) et 5 classes élémentaires", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "La demi-pension est assuréee par une société de restauration avec des repas préparés sur place.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Une garderie est proposée à partir de 7h45 et jusqu’à 18h15.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}	2026-01-14 10:24:36.147551+01	2026-01-14 10:25:05.1138+01
244deb2e-67c7-448c-8f61-6f0d05f62b15	a67777de-6746-4910-823f-ec604fa6363a	{"type": "doc", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "ALLER A LA RENCONTRE DE DIEU :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Se construire dans un environnement porteur de sens", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Aimer Dieu : découvrir la Parole, proposer, célébrer", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Vivre en frères : Accueillir, Participer, S’engager, s’entraider", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Servir son prochain : prendre soin des plus fragiles, solidarité", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "VIVRE EN RELATION :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école de quartier implantée dans son environnement local et paroissial", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école ouverte sur le monde", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école respectueuse de chacun pour encourager la confiance et la Paix", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école qui développe l’écoute pour favoriser les échanges", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école qui célèbre dans la Joie", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "SE CONNAITRE :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de faire des choix en considérant leur portée.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de développer différentes intelligences.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de reconnaître leurs talents, de les exprimer et de les valoriser.", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 10:32:37.107453+01	2026-01-14 10:38:38.057298+01
dcaab956-20f3-42c8-8c2a-caf9609681f3	5943387f-6a9c-462b-a669-9f2285d73a86	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": "center"}, "content": [{"text": "Établissement privé catholique sous contrat avec l’État, l’École catholique Jeanne d’Arc-Le Bouscat est placée sous la tutelle de la Direction Diocésaine de l’Enseignement Catholique de Gironde.", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}, "content": [{"text": "À ce double titre, elle respecte les programmes de l’Éducation Nationale, ainsi que les orientations éducatives diocésaines.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "École de quartier, familiale et chaleureuse, elle accueille tous les enfants et leur famille qui acceptent et respectent le projet éducatif.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre école a pour vocation d’être une école qui accueille, éduque, accompagne, donne des repères, propose la foi et annonce le Christ.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre communauté éducative porte la responsabilité, l’ambition et l’espérance d’accompagner chacun pour devenir des personnalités autonomes et responsables, capables de choix libres.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre école est un lieu privilégié pour vivre en communauté d’école et s’enrichir des échanges entre la paroisse, la mairie, les familles et l’équipe éducative et les différents intervenants.", "type": "text"}, {"type": "hardBreak"}, {"text": "Chacun est ainsi appelé à œuvrer, dans la joie et l’Espérance, pour le bien commun.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "« Tous les hommes de n’importe quelle race, âge ou condition, possèdent, en tant qu’ils jouissent de la dignité de personne, un droit inaliénable à une éducation qui réponde à leur vocation propre, soit conforme à leur tempérament, à la différence des sexes, à la culture et aux traditions nationales, en même temps qu’ouverte aux échanges fraternels avec les autres peuples pour favoriser l’unité véritable et la paix dans le monde. »", "type": "text", "marks": [{"type": "italic"}]}, {"type": "hardBreak", "marks": [{"type": "italic"}]}, {"text": "Concile Vatican II, Déclaration conciliaire Gravissimum educationis", "type": "text", "marks": [{"type": "italic"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 10:27:57.045492+01	2026-01-14 11:31:44.931067+01
493ea1b0-7c8b-4655-b9a8-84bf13f3a9e3	cf221b63-3868-42c3-ac1a-ee9e456eadef	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "L’OGEC c’est quoi ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OGEC ou Organisme de Gestion de l’Enseignement Catholique", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}, {"text": " ", "type": "text"}, {"text": "est une association loi 1901, initiée par l’Enseignement Catholique.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Toute école privée catholique sous contrat avec l’État est gérée par un Organisme de Gestion de l’Enseignement Catholique.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "En ce qui concerne notre école, cette association s’appelle OJAB (OGEC de Jeanne d’Arc le Bouscat).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Comment est composé le Bureau ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OJAB comporte un Conseil d’Administration et un bureau, désigné par le Conseil d’Administration. Le bureau assure le bon fonctionnement de l’association.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Au quotidien, la délégation de gestion est donnée au Chef d’Établissement, qui est associé au fonctionnement de l’OGEC et assiste à toutes les réunions.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Les membres de l’OGEC sont des bénévoles au service de l’Enseignement Catholique, dans le respect de ses valeurs.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Quelles sont les missions de l’OGEC ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OGEC est en charge :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– du budget de l’école (établissement et suivi) de la tenue des comptes,", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– de la détermination de la contribution demandée aux familles,", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– du paiement des charges de fonctionnement de l’établissement, etc…", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "L’OGEC doit également veiller à la gestion des locaux, à leur entretien, à leur rénovation, à leur aménagement et à leur agrandissement en se préoccupant des questions d’hygiène et de sécurité. L’OGEC est aussi l’employeur du personnel non-enseignant de l’établissement qu’il rémunère directement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}	2026-01-14 11:01:34.679564+01	2026-01-14 11:02:46.131436+01
\.


--
-- Data for Name: contenu_titre; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.contenu_titre (id_contenu_titre, id_section_fk, is_mega, titre1, titre2, description, created_at, updated_at) FROM stdin;
3370eb0b-8c0d-49e1-affb-19723c67f3cf	ba66e409-f0f8-44fe-91a8-d7c67eadc1ef	f	HISTOIRE DE L’ÉCOLE	HISTOIRE DE L’ÉCOLE		2026-01-12 14:34:38.167872+01	2026-01-14 12:36:47.895636+01
74242580-d9a1-492c-bcf9-3cde032110dc	3d8b5765-479b-43b8-af29-b52d9dbeefa4	f	PRÉ INSCRIPTION			2025-12-18 16:05:21.237803+01	2025-12-19 09:37:28.026629+01
916aa856-e9c0-4965-9335-f64aecd1b6ff	67c6f5df-b954-46c1-8cd4-60b4c83aa690	t	CONTACT		VOUS SOUHAITEZ NOUS CONTACTER ?	2025-12-18 16:05:21.237803+01	2025-12-19 09:59:43.708983+01
b8b0c9cd-e848-4389-9440-b229dab5ea1b	f20e7d57-5f0b-4b03-a234-fe5aa76437f1	t	PLUS		Nos autres pages	2025-12-18 16:05:21.237803+01	2025-12-19 11:11:02.991855+01
ee613f13-791a-47d7-bc0c-b779cb1b90dc	8446c363-0b39-4cbe-a99a-da2473aeee2a	f	PROJET PASTORAL			2025-12-18 16:05:21.237803+01	2026-01-07 17:11:58.127625+01
307d2b5e-749e-4889-8061-9fac7d12f43f	9cdb591f-c234-436f-800b-513fe5420f22	f	RÈGLEMENT INTÉRIEUR			2025-12-18 16:05:21.237803+01	2026-01-07 17:31:28.927362+01
f925e1c3-40bd-4f3d-9b21-d7899cdd91e0	b1386907-04fd-4e23-b527-200f3204653e	f	PROJET PÉDAGOGIQUE test	PROJET PÉDAGOGIQUE		2025-12-17 13:01:53.424746+01	2026-01-08 11:39:53.735273+01
c1509b60-8fab-457f-a481-4d074a440d91	121ace6e-3bba-49ce-a70f-ff02bac25060	f	INSTITUTION JEANNE D’ARC		ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE, sous CONTRAT AVEC L’ETAT	2026-01-12 15:40:06.859077+01	2026-01-12 15:42:27.442054+01
7ef6e902-3dd3-434e-8a0c-7a8ed5eb10f4	8c42367f-f686-477e-8145-19dbee03da3c	t	LES PROJETS		INSTITUTION JEANNE D’ARC – LE BOUSCAT	2025-12-18 16:05:21.237803+01	2026-01-13 12:21:09.108274+01
7f73500c-65ad-42de-bd3f-4c40ff44ee86	5247c29a-59c4-41d9-9e50-139cd15ae654	f	PROJET ÉDUCATIF	PROJET ÉDUCATIF DE L’ÉTABLISSEMENT	Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations.	2025-12-18 16:05:21.237803+01	2026-01-14 10:27:44.445917+01
779d8f80-2331-4fac-bd35-61b22f4402de	99950c5a-de9f-46b6-9dd9-bc5c453e6ef0	f	École directe	ÉCOLE DIRECTE		2025-12-18 16:05:21.237803+01	2026-01-14 10:43:32.770775+01
046f0fd6-adb9-4f47-9ecd-99907e248697	6b8b5046-370e-4bcf-9933-86a18f9d539f	f	BLOUSES JDA		Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023	2025-12-18 16:05:21.237803+01	2026-01-14 10:55:07.548766+01
0e94fba2-728f-4240-abf0-8a9418a578d2	ba84e21b-78ba-4be4-b0d9-f1f7fba158ab	f	TARIFS	TARIFS		2025-12-18 16:05:21.237803+01	2026-01-14 10:59:40.54787+01
aa14ddd6-783d-4f44-b0fa-0891205e94d3	93e05a7b-2549-49d2-8b23-e64e8abcb1d2	f	OGEC	OGEC – Organisme de Gestion de l’Enseignement Catholique		2025-12-18 16:05:21.237803+01	2026-01-14 11:01:23.06294+01
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.page (id_page, page_url, nom, created_at, updated_at) FROM stdin;
e11935b9-f19d-41ee-a061-d3f9bd26afde	projets/projet-pedagogique	Projet Pédagogique	2025-12-17 12:58:24.400635+01	2025-12-17 12:58:24.400635+01
8166954f-eb2d-48ed-a915-e207ae1406e4	/	Accueil	2025-12-18 15:50:33.084039+01	2025-12-18 15:50:33.084039+01
74d676f1-767e-4350-8a41-9c1c0999faf7	projets/projet-educatif	Projet Éducatif	2025-12-18 15:50:33.084039+01	2025-12-18 15:50:33.084039+01
ccd9338f-0f5c-42a2-9b3e-465645c80ff2	projets/projet-pastoral	Projet Pastoral	2025-12-18 15:50:33.084039+01	2025-12-18 15:50:33.084039+01
8cecaa91-a539-45fe-8151-a8650934ee7a	projets	Projets	2025-12-18 15:50:33.084039+01	2025-12-19 09:30:17.003798+01
a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	pre-inscriptions	Pré-inscriptions	2025-12-18 15:50:33.084039+01	2025-12-19 09:31:08.545657+01
60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	plus	Plus	2025-12-18 15:50:33.084039+01	2025-12-19 09:31:35.090148+01
295029ce-e0e9-475a-ae67-574139fa31b2	plus/ecole-directe	École Directe	2025-12-18 15:50:33.084039+01	2025-12-19 09:32:25.642048+01
6446302e-8285-44c0-95df-b49cf8b080bb	plus/reglement	Règlement intérieur	2025-12-18 15:50:33.084039+01	2025-12-19 09:33:11.642162+01
c336b0b8-e554-494d-8837-2f8e2bf4bc85	plus/blouses	Blouses JDA	2025-12-18 15:50:33.084039+01	2025-12-19 09:33:33.834272+01
c740cf55-6c49-4919-b2d8-e1f6e74e0230	plus/tarifs	Tarifs	2025-12-18 15:50:33.084039+01	2025-12-19 09:33:55.258417+01
f7c70f0c-23ce-4736-9328-15237670045c	plus/ogec	OGEC	2025-12-18 15:50:33.084039+01	2025-12-19 09:34:35.577699+01
64d857cc-b5f2-4b09-9024-46789bfef3ea	contact	Contact	2025-12-18 15:50:33.084039+01	2025-12-19 09:34:56.21774+01
9acbbb90-c4da-48eb-b825-ad27d3e72247	header	Barre de navigation	2026-01-05 10:37:33.120298+01	2026-01-05 10:37:33.120298+01
f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	footer	Pied de page	2026-01-05 10:37:33.120298+01	2026-01-05 10:37:33.120298+01
d3d52cd8-5458-44a7-bf81-3f4986377e6a	presentation-histoire	Histoire de l'école	2026-01-12 14:34:20.978216+01	2026-01-12 14:34:20.978216+01
663db8d8-f940-4408-bd6f-53dca0fe54c6	/footer	Footer	2026-01-14 08:54:21.849405+01	2026-01-14 08:54:21.849405+01
\.


--
-- Data for Name: pave_bloc; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.pave_bloc (id_pave_bloc, id_contenu_pave_fk, icone, soustitre, description1, lien_vers, created_at, updated_at, description2, description3, description4, description5, description6, description7) FROM stdin;
5413dc29-a043-4568-a266-1faa9d43d061	fd346e21-5871-4d15-a152-53f3c8671fc1	BigSchoolBigIcon	PROJET ÉDUCATIF	Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. Découvrir le projet éducatif de l’établissement	/projets/projet-educatif	2026-01-13 12:21:24.770138+01	2026-01-13 12:23:30.264241+01						
e35d6f5a-8368-4962-8284-841fc1c80251	fd346e21-5871-4d15-a152-53f3c8671fc1	BigReaderBigIcon	PROJET PÉDAGOGIQUE	Nous favorisons l’épanouissement de nos élèves afin qu’ils progressent scolairement et qu’ils grandissent en humanité. Découvrir le projet pédagogique de l’établissement	/projets/projet-pedagogique	2026-01-13 12:24:00.797562+01	2026-01-13 12:24:40.820949+01						
c3d26cb1-b4b0-4a49-ab42-f7d1814c0cfe	fd346e21-5871-4d15-a152-53f3c8671fc1	BigChristianCrossBigIcon	PROJET PASTORAL	Vivre en frère, découvrir la parole de dieu. Découvrir le projet pastorale de l’établissement\n\n	/projets/projet-pastoral	2026-01-13 12:24:48.366293+01	2026-01-13 12:26:56.072672+01						
0b5a82a5-f747-4155-bd8b-a0c263eb0820	33da439e-f856-4562-ab64-1db067c416a1	BigSchoolBigIcon	PROJET ÉDUCATIF		/projets/projet-educatif	2026-01-13 15:45:09.389544+01	2026-01-13 16:00:33.297093+01						
57cd76a1-709c-4d71-b9a5-9b73dbb06b9a	33da439e-f856-4562-ab64-1db067c416a1	BigReaderBigIcon	PROJET PÉDAGOGIQUE		/projets/projet-pedagogique	2026-01-13 15:45:15.039797+01	2026-01-13 16:01:13.492833+01						
32e590eb-1cd0-4b4d-bff6-f789b716fa5e	33da439e-f856-4562-ab64-1db067c416a1	BigChristianCrossBigIcon	PROJET PASTORAL		/projets/projet-pastoral	2026-01-13 16:00:42.542358+01	2026-01-13 16:01:40.275645+01						
29f3ed1c-84ce-4d8e-9b14-ae36ac87e78a	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallHereBigIcon	Adresse	45 Rue Francis de Pressensé		2026-01-13 16:51:40.480473+01	2026-01-13 17:04:48.866874+01	33110 Le Bouscat					
16c5c138-cec3-4758-96f5-113a9f30d440	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallLetterBigIcon	Courriel	administratif@jeannedarc33.fr		2026-01-13 16:51:42.080477+01	2026-01-13 17:22:51.551828+01						
51798fc2-043c-4e38-881a-e3aa79ae69cb	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallClockBigIcon	Horaires	Horaires de classe :		2026-01-13 16:51:43.205524+01	2026-01-13 17:23:44.760827+01	8 h 45 12 h 00 et 13 h 30 – 16 h 30	Accueil en garderie à partir de :	7 h 45 jusqu’à 18 h 15.			
67ac043b-f786-4d0b-984d-ac9064f146b4	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallPhoneBigIcon	Numéro de téléphone	(+33)5 56 08 52 16		2026-01-13 16:52:01.606717+01	2026-01-13 17:24:21.245045+01						
62fed117-04d0-4b89-8ac4-50242e4de4e8	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Horaires de classe	Lundi, mardi, jeudi et vendredi		2026-01-14 09:12:25.564743+01	2026-01-14 09:21:11.877761+01	08h45 - 12h00 et 13h30 - 16h30					
bafaafdf-11a9-436a-a649-303ec5eda890	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Horaires de garderie	Lundi, mardi, jeudi et vendredi		2026-01-14 09:13:16.100336+01	2026-01-14 09:21:43.378094+01	À partir de 07h45 et jusqu'à 18h15					
792420fc-0089-40be-9c98-8e718b53dcbe	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Contact & Adresse	Adresse : 45 Rue Francis de Préssensé 33110 Le Bouscat		2026-01-14 09:13:17.224938+01	2026-01-14 09:23:04.843817+01	05 56 08 52 16	administratif@jeannedarc33.fr				
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.section (id_section, id_page_fk, type, revert, created_at, updated_at) FROM stdin;
b1386907-04fd-4e23-b527-200f3204653e	e11935b9-f19d-41ee-a061-d3f9bd26afde	Titre	f	2025-12-17 13:00:06.554458+01	2025-12-17 13:00:06.554458+01
2e5b0548-c923-45c8-80b5-6e045a4877f5	e11935b9-f19d-41ee-a061-d3f9bd26afde	Texte	f	2025-12-17 13:00:26.755482+01	2025-12-17 13:00:26.755482+01
8c42367f-f686-477e-8145-19dbee03da3c	8cecaa91-a539-45fe-8151-a8650934ee7a	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
5247c29a-59c4-41d9-9e50-139cd15ae654	74d676f1-767e-4350-8a41-9c1c0999faf7	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
8446c363-0b39-4cbe-a99a-da2473aeee2a	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
3d8b5765-479b-43b8-af29-b52d9dbeefa4	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
f20e7d57-5f0b-4b03-a234-fe5aa76437f1	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
99950c5a-de9f-46b6-9dd9-bc5c453e6ef0	295029ce-e0e9-475a-ae67-574139fa31b2	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
9cdb591f-c234-436f-800b-513fe5420f22	6446302e-8285-44c0-95df-b49cf8b080bb	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
6b8b5046-370e-4bcf-9933-86a18f9d539f	c336b0b8-e554-494d-8837-2f8e2bf4bc85	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
ba84e21b-78ba-4be4-b0d9-f1f7fba158ab	c740cf55-6c49-4919-b2d8-e1f6e74e0230	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
93e05a7b-2549-49d2-8b23-e64e8abcb1d2	f7c70f0c-23ce-4736-9328-15237670045c	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
67c6f5df-b954-46c1-8cd4-60b4c83aa690	64d857cc-b5f2-4b09-9024-46789bfef3ea	Titre	f	2025-12-18 15:59:06.672671+01	2025-12-18 15:59:06.672671+01
8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 11:04:17.330427+01	2026-01-05 11:04:17.330427+01
6c86d086-0014-4b2c-ad71-573706d345e1	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 11:04:26.306782+01	2026-01-05 11:04:26.306782+01
05ee1e16-c142-42b5-b459-afcc593e3393	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 11:04:34.767728+01	2026-01-05 11:04:34.767728+01
516ca4e0-1661-4991-ab84-b5d5b3b52a27	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 11:04:45.743819+01	2026-01-05 11:04:45.743819+01
bed09afd-02b1-4036-87a7-8a95c7918a28	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 11:04:54.893304+01	2026-01-05 11:04:54.893304+01
610a236a-6c92-46e1-b281-41060ac503e8	e11935b9-f19d-41ee-a061-d3f9bd26afde	ImageTexte	t	2025-12-17 13:00:16.65258+01	2026-01-07 15:58:29.185155+01
4e3b39ec-7f51-4444-a2ec-b318c9522e0e	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	ImageTexte	t	2026-01-07 17:12:05.574326+01	2026-01-07 17:12:09.64663+01
30c8a13e-ac22-4c2d-a150-dca3093f3661	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	Image	f	2026-01-07 17:19:13.440566+01	2026-01-07 17:19:13.440566+01
4ac5f0aa-48d0-4ee1-b342-2c31801f7dc4	6446302e-8285-44c0-95df-b49cf8b080bb	Pdf	f	2026-01-07 17:31:34.42634+01	2026-01-07 17:31:34.42634+01
640a25da-7d94-4216-97a9-806118e14fbc	c336b0b8-e554-494d-8837-2f8e2bf4bc85	BandeauBtn	f	2026-01-09 08:51:47.720269+01	2026-01-09 08:51:47.720269+01
ba66e409-f0f8-44fe-91a8-d7c67eadc1ef	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Titre	f	2026-01-12 14:34:38.11997+01	2026-01-12 14:34:38.11997+01
121ace6e-3bba-49ce-a70f-ff02bac25060	8166954f-eb2d-48ed-a915-e207ae1406e4	TitreImage	t	2026-01-12 15:40:06.723857+01	2026-01-12 15:40:10.954859+01
24927bed-1f90-4a4b-995f-9c7a548e8fa2	8166954f-eb2d-48ed-a915-e207ae1406e4	BandeauBtn	f	2026-01-12 15:40:23.316658+01	2026-01-12 15:40:23.316658+01
3ec7ccdc-46fc-426d-8cbb-92d38d59c10e	8cecaa91-a539-45fe-8151-a8650934ee7a	PavesNav	f	2026-01-13 12:21:16.820055+01	2026-01-13 12:21:16.820055+01
dad61c44-7a22-4307-8e63-cbe1a7847346	8cecaa91-a539-45fe-8151-a8650934ee7a	Image	f	2026-01-13 14:22:29.757882+01	2026-01-13 14:22:29.757882+01
fcb5856f-3ac2-4d04-becb-081b588b0464	8166954f-eb2d-48ed-a915-e207ae1406e4	PavesNav	f	2026-01-13 14:23:47.340711+01	2026-01-13 14:23:47.340711+01
d789a75b-2f50-418a-b4a6-00e77dfe6581	64d857cc-b5f2-4b09-9024-46789bfef3ea	PavesNav	f	2026-01-13 16:51:35.628447+01	2026-01-13 16:51:35.628447+01
2190e0a1-cf08-4f3c-98a8-002c1e4ad2a1	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	PavesNav	f	2026-01-14 08:57:35.872295+01	2026-01-14 08:57:35.872295+01
fbe7a9d9-a622-437b-976b-b2082ead2539	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Texte	f	2026-01-14 10:20:39.529646+01	2026-01-14 10:20:39.529646+01
23b44287-025a-4bf2-befa-c36a9dc914a3	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Texte	f	2026-01-14 10:24:36.113688+01	2026-01-14 10:24:36.113688+01
8a1ed75d-0ad1-4339-9cbe-45fe3418009a	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Image	f	2026-01-14 10:25:33.882639+01	2026-01-14 10:25:33.882639+01
5943387f-6a9c-462b-a669-9f2285d73a86	74d676f1-767e-4350-8a41-9c1c0999faf7	Texte	f	2026-01-14 10:27:56.98067+01	2026-01-14 10:27:56.98067+01
a67777de-6746-4910-823f-ec604fa6363a	74d676f1-767e-4350-8a41-9c1c0999faf7	ImageTexte	f	2026-01-14 10:32:36.947587+01	2026-01-14 10:32:36.947587+01
df2360f2-49bc-46c9-a7b5-9dce3de86043	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	BandeauBtn	f	2026-01-14 10:41:39.265706+01	2026-01-14 10:41:39.265706+01
cad4f442-ee3d-48a1-949c-e71800b3beba	295029ce-e0e9-475a-ae67-574139fa31b2	BandeauBtn	f	2026-01-14 10:43:38.349744+01	2026-01-14 10:43:38.349744+01
62f8c8a7-f586-4a6b-bece-806cb37675a7	c336b0b8-e554-494d-8837-2f8e2bf4bc85	Pdf	f	2026-01-14 10:57:08.009639+01	2026-01-14 10:57:08.009639+01
1fd4931c-5d7e-40c3-b0a6-409b099dd5aa	c336b0b8-e554-494d-8837-2f8e2bf4bc85	BandeauBtn	f	2026-01-14 10:58:29.79423+01	2026-01-14 10:58:29.79423+01
602196fd-53b4-4752-b05a-cc569b22b61a	c740cf55-6c49-4919-b2d8-e1f6e74e0230	Pdf	f	2026-01-14 10:59:55.86946+01	2026-01-14 10:59:55.86946+01
cf221b63-3868-42c3-ac1a-ee9e456eadef	f7c70f0c-23ce-4736-9328-15237670045c	ImageTexte	t	2026-01-14 11:01:34.550495+01	2026-01-14 11:01:37.328608+01
f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	d3d52cd8-5458-44a7-bf81-3f4986377e6a	ImageTexte	f	2026-01-14 10:16:38.94894+01	2026-01-14 12:36:52.291154+01
\.


--
-- Data for Name: text_index; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.text_index (id_text_index, id_page_fk, ref_table, ref_id, content_plaintext, created_at, updated_at) FROM stdin;
86855bdb-3877-4542-85de-f4e98779e18a	e11935b9-f19d-41ee-a061-d3f9bd26afde	page	e11935b9-f19d-41ee-a061-d3f9bd26afde	 Projet Pédagogique	2026-01-15 17:53:42.55224+01	2026-01-15 17:56:57.908539+01
0527008d-ef5a-4195-8b13-f8ea2cd303c3	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_titre	f925e1c3-40bd-4f3d-9b21-d7899cdd91e0	 PROJET PÉDAGOGIQUE test PROJET PÉDAGOGIQUE	2026-01-15 17:53:42.584237+01	2026-01-15 17:56:57.919148+01
3a210096-c6c4-474b-9eae-ed56cc8994ce	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_texte	fec83639-9b1a-4480-929e-2c2b01cb7c52	  S’émerveiller d’apprendre Un climat de classe et d’école serein pour bien apprendre et bien vivre ensemble La Classe-qualité : réflexion et attention afin de répondre aux besoins des élèves pour bien apprendre. Donner la possibilité à nos élèves de restituer et d’offrir : lors des spectacles, de mises en scène, de chorale… S’engager activement dans ses apprentissages Accompagner nos élèves à développer le questionnement et la réflexion Travailler ensemble Se mettre en projet Apprendre à apprendre Les apports des neurosciences et de la gestion mentale pour mieux apprendre La place du statut de l’erreur La cohérence pédagogique	2026-01-15 17:53:42.59143+01	2026-01-15 17:56:57.921776+01
d780eca2-09ec-433d-815b-ff5fb00eb976	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_texte	df61c9a8-ea5c-4a72-9724-05b8875fdee2	  L’école met au centre de la vie scolaire 6 piliers. La culture littéraire : « Silence On Lit », mini-médiathèque, les incorruptibles, participation au salon du livre du Bouscat. Le sport et l’éducation sportive : utilisation des installations sportives et animateurs sportifs de la ville et de l’école, animations sportives sur la pause méridienne. La culture numérique : Toutes les classes de l’école est équipée de VPI, et d’une flotte d’IPAD qui servent de support aux apprentissages des élèves. L’anglais : des cours d’anglais et des « English Games » sont proposés à tous les élèves (de la Petite Section au CM2) par une personne native anglophone. Un projet d’école annuel : chaque année, un thème d’année est choisi en lien avec un mode différent d’intelligence. Les activités culturelles : Tout au long de l’année, les élèves participent à des spectacles, des expositions… , en lien et en illustration avec les apprentissages.	2026-01-15 17:53:42.592872+01	2026-01-15 17:56:57.92257+01
3acfed1c-e433-4809-9dad-125256f3d753	8166954f-eb2d-48ed-a915-e207ae1406e4	page	8166954f-eb2d-48ed-a915-e207ae1406e4	 Accueil	2026-01-15 17:56:57.932659+01	2026-01-15 17:56:57.932659+01
2e843172-d7c8-4520-addb-48fe26496d85	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_titre	c1509b60-8fab-457f-a481-4d074a440d91	 ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE, sous CONTRAT AVEC L’ETAT INSTITUTION JEANNE D’ARC	2026-01-15 17:56:57.935214+01	2026-01-15 17:56:57.935214+01
65ef7eb3-7749-4c9b-ad90-bdf3cfc2802c	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_pave	33da439e-f856-4562-ab64-1db067c416a1	 LE PROJET D’ÉTABLISSEMENT	2026-01-15 17:56:57.938089+01	2026-01-15 17:56:57.938089+01
5c4ef6b0-8eca-48ab-a50e-ce6d6359882b	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_bandeaubtn	a55f1030-e11f-4545-966f-d1dac1e726e0	 pré-inscription Demande de Pré-Inscription de votre enfant à l’école JEANNE D’ARC pré-inscriptions	2026-01-15 17:56:57.939422+01	2026-01-15 17:56:57.939422+01
90109bd3-efd4-42ef-b9d3-85028b50ef4d	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	243fa9b0-f121-45f8-ab2f-07eb966b9e6d	 nous contacter	2026-01-15 17:56:57.940813+01	2026-01-15 17:56:57.940813+01
c9b385a1-de37-435c-a8ca-d3296af79db4	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	e72ad051-52db-4210-af60-5dc7759ba3da	 voir le projet d'établissement	2026-01-15 17:56:57.941523+01	2026-01-15 17:56:57.941523+01
da3eb810-56cc-44f9-b731-836beadf228b	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	2f196cfe-4e52-4af7-a829-03846f3151fc	 histoire de l'école	2026-01-15 17:56:57.942185+01	2026-01-15 17:56:57.942185+01
a1a34f3c-d95d-4c84-80af-991ae2892e93	74d676f1-767e-4350-8a41-9c1c0999faf7	page	74d676f1-767e-4350-8a41-9c1c0999faf7	 Projet Éducatif	2026-01-15 17:56:57.944064+01	2026-01-15 17:56:57.944064+01
d8d2dbe7-3190-4c90-ab92-8305425cd8ba	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_titre	7f73500c-65ad-42de-bd3f-4c40ff44ee86	 Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. PROJET ÉDUCATIF PROJET ÉDUCATIF DE L’ÉTABLISSEMENT	2026-01-15 17:56:57.946553+01	2026-01-15 17:56:57.946553+01
5b757209-0d4c-4132-9e0e-2a6aa56dc419	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_texte	244deb2e-67c7-448c-8f61-6f0d05f62b15	  ALLER A LA RENCONTRE DE DIEU : Se construire dans un environnement porteur de sens Aimer Dieu : découvrir la Parole, proposer, célébrer Vivre en frères : Accueillir, Participer, S’engager, s’entraider Servir son prochain : prendre soin des plus fragiles, solidarité VIVRE EN RELATION : Une école de quartier implantée dans son environnement local et paroissial Une école ouverte sur le monde Une école respectueuse de chacun pour encourager la confiance et la Paix Une école qui développe l’écoute pour favoriser les échanges Une école qui célèbre dans la Joie SE CONNAITRE : Permettre aux élèves de faire des choix en considérant leur portée. Permettre aux élèves de développer différentes intelligences. Permettre aux élèves de reconnaître leurs talents, de les exprimer et de les valoriser.	2026-01-15 17:56:57.948322+01	2026-01-15 17:56:57.948322+01
6853f7a9-fd81-4511-afd2-6058c86b2b12	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_titre	3370eb0b-8c0d-49e1-affb-19723c67f3cf	 HISTOIRE DE L’ÉCOLE HISTOIRE DE L’ÉCOLE	2026-01-15 17:56:58.054035+01	2026-01-15 17:56:58.054035+01
e84170cf-0d51-428e-bc95-2bf346be5004	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_texte	dcaab956-20f3-42c8-8c2a-caf9609681f3	  Établissement privé catholique sous contrat avec l’État, l’École catholique Jeanne d’Arc-Le Bouscat est placée sous la tutelle de la Direction Diocésaine de l’Enseignement Catholique de Gironde. À ce double titre, elle respecte les programmes de l’Éducation Nationale, ainsi que les orientations éducatives diocésaines. École de quartier, familiale et chaleureuse, elle accueille tous les enfants et leur famille qui acceptent et respectent le projet éducatif. Notre école a pour vocation d’être une école qui accueille, éduque, accompagne, donne des repères, propose la foi et annonce le Christ. Notre communauté éducative porte la responsabilité, l’ambition et l’espérance d’accompagner chacun pour devenir des personnalités autonomes et responsables, capables de choix libres. Notre école est un lieu privilégié pour vivre en communauté d’école et s’enrichir des échanges entre la paroisse, la mairie, les familles et l’équipe éducative et les différents intervenants. Chacun est ainsi appelé à œuvrer, dans la joie et l’Espérance, pour le bien commun. « Tous les hommes de n’importe quelle race, âge ou condition, possèdent, en tant qu’ils jouissent de la dignité de personne, un droit inaliénable à une éducation qui réponde à leur vocation propre, soit conforme à leur tempérament, à la différence des sexes, à la culture et aux traditions nationales, en même temps qu’ouverte aux échanges fraternels avec les autres peuples pour favoriser l’unité véritable et la paix dans le monde. » Concile Vatican II, Déclaration conciliaire Gravissimum educationis	2026-01-15 17:56:57.94924+01	2026-01-15 17:56:57.94924+01
5f896978-cb37-4700-881c-5fd60a3a1a07	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	page	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	 Projet Pastoral	2026-01-15 17:56:57.955373+01	2026-01-15 17:56:57.955373+01
6b6cc3de-e170-44b7-ac95-c79e6294044f	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	contenu_titre	ee613f13-791a-47d7-bc0c-b779cb1b90dc	 PROJET PASTORAL	2026-01-15 17:56:57.956634+01	2026-01-15 17:56:57.956634+01
9711a3e4-73fe-4d37-bd56-28b3ff3aff49	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	contenu_texte	b7895663-f2b4-49c5-bd35-b0381032d3b5	  Vivre en Frères : Écoute, accueil, convivialité : rencontres proposées aux familles pour mieux se connaître et échanger. Service : mise à disposition des talents des uns et des autres pour l’école et l’entraide. Actions solidaires. Pour découvrir la parole de Dieu : Éveil à la foi pour les plus jeunes et catéchèse pour les autres T emps pastoraux et communautaires : 3 samedis dans l’année Temps spirituels, prières, célébrations	2026-01-15 17:56:57.95793+01	2026-01-15 17:56:57.95793+01
0dddfcb5-c2b8-4383-91ce-c1aad7b81882	8cecaa91-a539-45fe-8151-a8650934ee7a	page	8cecaa91-a539-45fe-8151-a8650934ee7a	 Projets	2026-01-15 17:56:57.964159+01	2026-01-15 17:56:57.964159+01
36c94791-afe1-4de0-a5cc-bc286130b362	8cecaa91-a539-45fe-8151-a8650934ee7a	contenu_titre	7ef6e902-3dd3-434e-8a0c-7a8ed5eb10f4	 INSTITUTION JEANNE D’ARC – LE BOUSCAT LES PROJETS	2026-01-15 17:56:57.965695+01	2026-01-15 17:56:57.965695+01
6d569b77-c2fe-41ee-8265-87ee4fef2938	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	page	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	 Pré-inscriptions	2026-01-15 17:56:57.97232+01	2026-01-15 17:56:57.97232+01
9a5580b2-7293-4439-b9b4-7a66739de5b9	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	contenu_titre	74242580-d9a1-492c-bcf9-3cde032110dc	 PRÉ INSCRIPTION	2026-01-15 17:56:57.973873+01	2026-01-15 17:56:57.973873+01
134eac5c-cf4e-44de-a468-c490db4b0467	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	contenu_bandeaubtn	cce2a1e0-463e-403e-89ac-35ec8e2d0795	  LIEN DE PRÉ-INSCRIPTION	2026-01-15 17:56:57.978509+01	2026-01-15 17:56:57.978509+01
7c5a3557-5d5e-484e-bb72-d84a1875140b	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	page	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	 Plus	2026-01-15 17:56:57.98079+01	2026-01-15 17:56:57.98079+01
001792b3-8d5c-4edb-90f7-b008deb4c38c	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	contenu_titre	b8b0c9cd-e848-4389-9440-b229dab5ea1b	 Nos autres pages PLUS	2026-01-15 17:56:57.982105+01	2026-01-15 17:56:57.982105+01
0c403602-9cdc-4f6a-b943-6f47ec2d2b73	295029ce-e0e9-475a-ae67-574139fa31b2	page	295029ce-e0e9-475a-ae67-574139fa31b2	 École Directe	2026-01-15 17:56:57.98704+01	2026-01-15 17:56:57.98704+01
ddb01de6-b057-4f7e-811d-2c97d28afffd	295029ce-e0e9-475a-ae67-574139fa31b2	contenu_titre	779d8f80-2331-4fac-bd35-61b22f4402de	 École directe ÉCOLE DIRECTE	2026-01-15 17:56:57.988342+01	2026-01-15 17:56:57.988342+01
b39ac5d1-d5b8-4c64-8c1e-511ab05eb043	295029ce-e0e9-475a-ae67-574139fa31b2	contenu_bandeaubtn	b1615ac4-2cda-43cd-965a-93dfe9b7ae56	 Accéder aux notes, aux devoirs et à toutes les informations de votre enfant à l’école école directe	2026-01-15 17:56:57.991222+01	2026-01-15 17:56:57.991222+01
a898f912-f078-4d1b-a602-5d66b8e43c7f	6446302e-8285-44c0-95df-b49cf8b080bb	page	6446302e-8285-44c0-95df-b49cf8b080bb	 Règlement intérieur	2026-01-15 17:56:57.994785+01	2026-01-15 17:56:57.994785+01
9a1ba75c-70e5-4ab2-8739-2a223f46da8a	6446302e-8285-44c0-95df-b49cf8b080bb	contenu_titre	307d2b5e-749e-4889-8061-9fac7d12f43f	 RÈGLEMENT INTÉRIEUR	2026-01-15 17:56:57.996549+01	2026-01-15 17:56:57.996549+01
f052959f-d87d-4515-a6b8-7b03e08a51e3	6446302e-8285-44c0-95df-b49cf8b080bb	contenu_pdf	e943d4b8-6444-4705-be99-1907d91bf5ac	 Règlement intérieur	2026-01-15 17:56:57.999363+01	2026-01-15 17:56:57.999363+01
2189088e-c328-44b2-8a5c-3668166f6ad3	c336b0b8-e554-494d-8837-2f8e2bf4bc85	page	c336b0b8-e554-494d-8837-2f8e2bf4bc85	 Blouses JDA	2026-01-15 17:56:58.002942+01	2026-01-15 17:56:58.002942+01
58e7a230-eb05-43ba-a496-064ad030d369	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_titre	046f0fd6-adb9-4f47-9ecd-99907e248697	 Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023 BLOUSES JDA	2026-01-15 17:56:58.004235+01	2026-01-15 17:56:58.004235+01
874a49e9-c0f6-45cc-867f-dac9f921ce96	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_pdf	7985ea3e-37a6-4516-8f11-83aceddc17d6	 Commande de la blouse Jeanne d'Arc	2026-01-15 17:56:58.006685+01	2026-01-15 17:56:58.006685+01
4821a78c-e0f5-479b-ad17-5082dd3970cc	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_bandeaubtn	cb24a194-f802-4364-828a-6e38ae3ca88e	 Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023 commander la blouse	2026-01-15 17:56:58.009114+01	2026-01-15 17:56:58.009114+01
e0838279-2a67-46ee-8ddc-405f3b02937f	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_bandeaubtn	371922a6-19cf-4d07-8fd7-c4383b873e75	 Commander la blouse	2026-01-15 17:56:58.01013+01	2026-01-15 17:56:58.01013+01
e466f9c7-02b1-40f3-9dc0-586e72103921	c740cf55-6c49-4919-b2d8-e1f6e74e0230	page	c740cf55-6c49-4919-b2d8-e1f6e74e0230	 Tarifs	2026-01-15 17:56:58.013044+01	2026-01-15 17:56:58.013044+01
c31ebfe6-047e-473d-ae20-7b502eef8357	c740cf55-6c49-4919-b2d8-e1f6e74e0230	contenu_titre	0e94fba2-728f-4240-abf0-8a9418a578d2	 TARIFS TARIFS	2026-01-15 17:56:58.014666+01	2026-01-15 17:56:58.014666+01
cef08487-ea12-414a-b168-89343d138946	c740cf55-6c49-4919-b2d8-e1f6e74e0230	contenu_pdf	11c1c10c-db3a-4f63-85c9-812d811d7ea8	 TARIFS 2025-2026	2026-01-15 17:56:58.017085+01	2026-01-15 17:56:58.017085+01
6a2df2c7-c97d-4e0a-bb59-82feac85b345	f7c70f0c-23ce-4736-9328-15237670045c	page	f7c70f0c-23ce-4736-9328-15237670045c	 OGEC	2026-01-15 17:56:58.021922+01	2026-01-15 17:56:58.021922+01
632985c8-9b60-4e65-a32b-cadd9ff0aefc	f7c70f0c-23ce-4736-9328-15237670045c	contenu_titre	aa14ddd6-783d-4f44-b0fa-0891205e94d3	 OGEC OGEC – Organisme de Gestion de l’Enseignement Catholique	2026-01-15 17:56:58.023095+01	2026-01-15 17:56:58.023095+01
cf53f675-568e-4ee3-97c3-90e2d296e40d	f7c70f0c-23ce-4736-9328-15237670045c	contenu_texte	493ea1b0-7c8b-4655-b9a8-84bf13f3a9e3	  L’OGEC c’est quoi ? L’OGEC ou Organisme de Gestion de l’Enseignement Catholique   est une association loi 1901, initiée par l’Enseignement Catholique. Toute école privée catholique sous contrat avec l’État est gérée par un Organisme de Gestion de l’Enseignement Catholique. En ce qui concerne notre école, cette association s’appelle OJAB (OGEC de Jeanne d’Arc le Bouscat). Comment est composé le Bureau ? L’OJAB comporte un Conseil d’Administration et un bureau, désigné par le Conseil d’Administration. Le bureau assure le bon fonctionnement de l’association. Au quotidien, la délégation de gestion est donnée au Chef d’Établissement, qui est associé au fonctionnement de l’OGEC et assiste à toutes les réunions. Les membres de l’OGEC sont des bénévoles au service de l’Enseignement Catholique, dans le respect de ses valeurs. Quelles sont les missions de l’OGEC ? L’OGEC est en charge : – du budget de l’école (établissement et suivi) de la tenue des comptes, – de la détermination de la contribution demandée aux familles, – du paiement des charges de fonctionnement de l’établissement, etc… L’OGEC doit également veiller à la gestion des locaux, à leur entretien, à leur rénovation, à leur aménagement et à leur agrandissement en se préoccupant des questions d’hygiène et de sécurité. L’OGEC est aussi l’employeur du personnel non-enseignant de l’établissement qu’il rémunère directement.	2026-01-15 17:56:58.024479+01	2026-01-15 17:56:58.024479+01
ca528faa-347c-4154-aa7d-5e4e374363b0	64d857cc-b5f2-4b09-9024-46789bfef3ea	page	64d857cc-b5f2-4b09-9024-46789bfef3ea	 Contact	2026-01-15 17:56:58.029867+01	2026-01-15 17:56:58.029867+01
75c029da-3623-4903-96a5-6f864685c512	64d857cc-b5f2-4b09-9024-46789bfef3ea	contenu_titre	916aa856-e9c0-4965-9335-f64aecd1b6ff	 VOUS SOUHAITEZ NOUS CONTACTER ? CONTACT	2026-01-15 17:56:58.031309+01	2026-01-15 17:56:58.031309+01
57204443-c5df-418d-b15b-62e73c51dc42	9acbbb90-c4da-48eb-b825-ad27d3e72247	page	9acbbb90-c4da-48eb-b825-ad27d3e72247	 Barre de navigation	2026-01-15 17:56:58.036942+01	2026-01-15 17:56:58.036942+01
5db8c3c0-4213-4e00-8ccf-52bd37e509e1	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	page	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	 Pied de page	2026-01-15 17:56:58.042339+01	2026-01-15 17:56:58.042339+01
53e14e88-77e3-482b-b3a7-fb315a53adff	d3d52cd8-5458-44a7-bf81-3f4986377e6a	page	d3d52cd8-5458-44a7-bf81-3f4986377e6a	 Histoire de l'école	2026-01-15 17:56:58.052691+01	2026-01-15 17:56:58.052691+01
cc13542d-cc94-4be0-bd71-6bc03bdf74fe	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	1b3cf84e-e381-4009-b3c9-367f546ab1eb	  L’école Jeanne d’Arc est officiellement créée le 29 août 1902. Le premier octobre 1902, Madame Estrampes ouvre l’école sur la propriété que possède son mari depuis 1884 au 45 rue Francis de Pressensé. École privée de filles, certes, où les registres portent parfois les noms d’Albert, Auguste, Paul… ! L’école se développe et les directrices se succèdent, Pauline Estrampes (1904), Angèle Lacrampe (1960) …. Melle Tricotet (1968). L’école est menacée de fermeture en 1968, quand Françoise Clion en prend la direction. Il faut faire ses preuves, patiemment, consciencieusement. Les garçons sont admis officiellement. Malgré les menaces qui pèsent sur l’enseignement libre, l’école résiste, sa réputation se répand. Un don généreux d’une ancienne maman de l’école permettra de rembourser un emprunt fait pour les travaux. En 1985, l’école signe un contrat d’association avec l’État. L’école se développe, dédouble des classes, diversifie ses activités pédagogiques et approfondit le travail d’équipe. En mars 2008, elle obtient de l’Inspection Académique l’ouverture d’une classe maternelle pour la rentrée 2008-2009. L’OGEC (organisme de gestion de l’établissement) décide alors d’un projet d’extension et de rénovation en 2009.	2026-01-15 17:56:58.055555+01	2026-01-15 17:56:58.055555+01
9c0c6fb8-3534-4dfe-9a8b-d96a971be538	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	b7797350-ac31-496a-bdb5-1a2bb9383209	  Les dates clés : 29 août 1902 : Création de l’école Jeanne d’arc, école privée de filles. 1er octobre 1902 : Ouverture de l’école : 2 classes – Mme Estrampes, directrice, sa fille Pauline est adjointe. 1er octobre 1904 : Pauline Estrampes devient directrice, Mme Estrampes, mère, reste adjointe. 1916 : 3 classes. 1957 : 7 classes. J usqu’en 1960, internat à l’école. 1960 : Angèle Lacrampe (adjointe depuis 1928) devient directrice puis MlleTricotet jusqu’en 1968 (classe de maternelle au collège 6/5ᵉ et 4/3ᵉ). 1968 : Fermeture du collège – Arrivée de Mme Clion à la direction. 1985 : Obtention du contrat d’association avec l’Etat. 2004 : Nomination de Mme Brigitte Dejean, à la direction de l’établissement. 2019 : Nomination de Mme Albane Motais de Narbonne, actuel chef d’établissement.	2026-01-15 17:56:58.056655+01	2026-01-15 17:56:58.056655+01
3b717d5c-56e7-4506-a5a7-93a7122df7d8	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	522a90bd-9621-46ac-886c-de5e58d34b3d	  Aujourd’hui Actuellement, nous accueillons 215 élèves de la petite section au CM2 répartis en 8 classes : 3 classes maternelles (accueil dès 3 ans) et 5 classes élémentaires La demi-pension est assuréee par une société de restauration avec des repas préparés sur place. Une garderie est proposée à partir de 7h45 et jusqu’à 18h15.	2026-01-15 17:56:58.05748+01	2026-01-15 17:56:58.05748+01
24275882-413b-42f1-b8f9-0c62580d1878	663db8d8-f940-4408-bd6f-53dca0fe54c6	page	663db8d8-f940-4408-bd6f-53dca0fe54c6	 Footer	2026-01-15 17:56:58.063286+01	2026-01-15 17:56:58.063286+01
9867bad4-69b2-4e67-9cc2-2c75423ca8b6	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	5413dc29-a043-4568-a266-1faa9d43d061	 PROJET ÉDUCATIF Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. Découvrir le projet éducatif de l’établissement	2026-01-15 18:22:02.434566+01	2026-01-15 18:22:02.434566+01
cb1bab43-e505-46d8-949d-8a3127b3bc5e	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	e35d6f5a-8368-4962-8284-841fc1c80251	 PROJET PÉDAGOGIQUE Nous favorisons l’épanouissement de nos élèves afin qu’ils progressent scolairement et qu’ils grandissent en humanité. Découvrir le projet pédagogique de l’établissement	2026-01-15 18:22:02.438698+01	2026-01-15 18:22:02.438698+01
481235a9-8d56-4639-9c8b-13ceb6fd7108	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	c3d26cb1-b4b0-4a49-ab42-f7d1814c0cfe	 PROJET PASTORAL Vivre en frère, découvrir la parole de dieu. Découvrir le projet pastorale de l’établissement\n\n	2026-01-15 18:22:02.440288+01	2026-01-15 18:22:02.440288+01
d5e751e4-7caf-47df-ae29-d521bf36e540	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	0b5a82a5-f747-4155-bd8b-a0c263eb0820	 PROJET ÉDUCATIF	2026-01-15 18:22:02.441436+01	2026-01-15 18:22:02.441436+01
e395b4b4-ebb0-4e52-8640-047384581af7	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	57cd76a1-709c-4d71-b9a5-9b73dbb06b9a	 PROJET PÉDAGOGIQUE	2026-01-15 18:22:02.442521+01	2026-01-15 18:22:02.442521+01
fc662719-29dc-4278-8af6-cefec23b5700	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	32e590eb-1cd0-4b4d-bff6-f789b716fa5e	 PROJET PASTORAL	2026-01-15 18:22:02.443607+01	2026-01-15 18:22:02.443607+01
c3a64ade-1c30-4419-984e-8428a7969a01	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	29f3ed1c-84ce-4d8e-9b14-ae36ac87e78a	 Adresse 45 Rue Francis de Pressensé 33110 Le Bouscat	2026-01-15 18:22:02.444999+01	2026-01-15 18:22:02.444999+01
d61406db-1bc1-4918-b751-360d556eb2dd	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	16c5c138-cec3-4758-96f5-113a9f30d440	 Courriel administratif@jeannedarc33.fr	2026-01-15 18:22:02.446148+01	2026-01-15 18:22:02.446148+01
6a57ab87-4cd3-414e-ab47-ef44bf950a83	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	51798fc2-043c-4e38-881a-e3aa79ae69cb	 Horaires Horaires de classe : 8 h 45 12 h 00 et 13 h 30 – 16 h 30 Accueil en garderie à partir de : 7 h 45 jusqu’à 18 h 15.	2026-01-15 18:22:02.447272+01	2026-01-15 18:22:02.447272+01
b006e437-5b1b-489b-866e-1f8ac20b1675	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	67ac043b-f786-4d0b-984d-ac9064f146b4	 Numéro de téléphone (+33)5 56 08 52 16	2026-01-15 18:22:02.448335+01	2026-01-15 18:22:02.448335+01
7885e37e-bb7b-459b-8b03-90dd0657b0ea	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	62fed117-04d0-4b89-8ac4-50242e4de4e8	 Horaires de classe Lundi, mardi, jeudi et vendredi 08h45 - 12h00 et 13h30 - 16h30	2026-01-15 18:22:02.449284+01	2026-01-15 18:22:02.449284+01
889a04c6-2143-40d7-afc7-9aefdcf3ea54	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	bafaafdf-11a9-436a-a649-303ec5eda890	 Horaires de garderie Lundi, mardi, jeudi et vendredi À partir de 07h45 et jusqu'à 18h15	2026-01-15 18:22:02.450235+01	2026-01-15 18:22:02.450235+01
68b03e45-341d-439c-b3e1-baab5d35f594	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	792420fc-0089-40be-9c98-8e718b53dcbe	 Contact & Adresse Adresse : 45 Rue Francis de Préssensé 33110 Le Bouscat 05 56 08 52 16 administratif@jeannedarc33.fr	2026-01-15 18:22:02.451172+01	2026-01-15 18:22:02.451172+01
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: sandalman
--

COPY public.utilisateur (id_utilisateur, email, name, password, is_admin, created_at, updated_at) FROM stdin;
\.


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_pkey PRIMARY KEY (id_contenu_bandeaubtn);


--
-- Name: contenu_contact contenu_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_pkey PRIMARY KEY (id_contenu_contact);


--
-- Name: contenu_headerbtn contenu_headerbtn_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_pkey PRIMARY KEY (id_contenu_headerbtn);


--
-- Name: contenu_image contenu_image_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_pkey PRIMARY KEY (id_contenu_image);


--
-- Name: contenu_pave contenu_pave_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_pkey PRIMARY KEY (id_contenu_pave);


--
-- Name: contenu_pdf contenu_pdf_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_pkey PRIMARY KEY (id_contenu_pdf);


--
-- Name: contenu_solobtn contenu_solobtn_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_pkey PRIMARY KEY (id_contenu_solobtn);


--
-- Name: contenu_texte contenu_texte_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_pkey PRIMARY KEY (id_contenu_texte);


--
-- Name: contenu_titre contenu_titre_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_pkey PRIMARY KEY (id_contenu_titre);


--
-- Name: page page_page_url_key; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_page_url_key UNIQUE (page_url);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id_page);


--
-- Name: pave_bloc pave_bloc_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_pkey PRIMARY KEY (id_pave_bloc);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id_section);


--
-- Name: text_index text_index_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_pkey PRIMARY KEY (id_text_index);


--
-- Name: text_index text_index_ref_unique; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_ref_unique UNIQUE (ref_id);


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: idx_text_index_content_plaintext; Type: INDEX; Schema: public; Owner: sandalman
--

CREATE INDEX idx_text_index_content_plaintext ON public.text_index USING gin (to_tsvector('french'::regconfig, content_plaintext));


--
-- Name: contenu_bandeaubtn update_contenu_bandeaubtn_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_bandeaubtn_updated_at BEFORE UPDATE ON public.contenu_bandeaubtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_contact update_contenu_contact_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_contact_updated_at BEFORE UPDATE ON public.contenu_contact FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_headerbtn update_contenu_headerbtn_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_headerbtn_updated_at BEFORE UPDATE ON public.contenu_headerbtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_image update_contenu_image_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_image_updated_at BEFORE UPDATE ON public.contenu_image FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pave update_contenu_pave_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_pave_updated_at BEFORE UPDATE ON public.contenu_pave FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pdf update_contenu_pdf_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_pdf_updated_at BEFORE UPDATE ON public.contenu_pdf FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_solobtn update_contenu_solobtn_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_solobtn_updated_at BEFORE UPDATE ON public.contenu_solobtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_texte update_contenu_texte_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_texte_updated_at BEFORE UPDATE ON public.contenu_texte FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_titre update_contenu_titre_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_contenu_titre_updated_at BEFORE UPDATE ON public.contenu_titre FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: page update_page_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_page_updated_at BEFORE UPDATE ON public.page FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: pave_bloc update_pave_bloc_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_pave_bloc_updated_at BEFORE UPDATE ON public.pave_bloc FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: section update_section_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_section_updated_at BEFORE UPDATE ON public.section FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: text_index update_text_index_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_text_index_updated_at BEFORE UPDATE ON public.text_index FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: utilisateur update_utilisateur_updated_at; Type: TRIGGER; Schema: public; Owner: sandalman
--

CREATE TRIGGER update_utilisateur_updated_at BEFORE UPDATE ON public.utilisateur FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_contact contenu_contact_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_page_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_page_fk_fkey FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_image contenu_image_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pave contenu_pave_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pdf contenu_pdf_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_solobtn contenu_solobtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_texte contenu_texte_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_titre contenu_titre_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: pave_bloc pave_bloc_id_contenu_pave_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_id_contenu_pave_fk FOREIGN KEY (id_contenu_pave_fk) REFERENCES public.contenu_pave(id_contenu_pave) ON DELETE CASCADE;


--
-- Name: section section_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: text_index text_index_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: sandalman
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: sandalman
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict UUFMb7iZ6bUqoEPne1AGhrOX6QIlWrd0uCIHSppuwv6lVuvFGkmTlYwdcaNABOu

