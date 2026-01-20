--
-- PostgreSQL database dump
--



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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    NEW.updated_at = NOW();

    RETURN NEW;

END;

$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contenu_bandeaubtn; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenu_contact; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenu_headerbtn; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenu_image; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenu_pave; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_pave (
    id_contenu_pave uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_pdf; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_pdf (
    id_contenu_pdf uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    pdf_url text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    pdf_titre text DEFAULT ''::text NOT NULL
);


--
-- Name: contenu_solobtn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_solobtn (
    id_contenu_solobtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_texte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_texte (
    id_contenu_texte uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    tiptap_content jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_titre; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page (
    id_page uuid DEFAULT gen_random_uuid() NOT NULL,
    page_url text NOT NULL,
    nom text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: pave_bloc; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: section; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.section (
    id_section uuid DEFAULT gen_random_uuid() NOT NULL,
    id_page_fk uuid NOT NULL,
    type text NOT NULL,
    revert boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: text_index; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_pkey PRIMARY KEY (id_contenu_bandeaubtn);


--
-- Name: contenu_contact contenu_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_pkey PRIMARY KEY (id_contenu_contact);


--
-- Name: contenu_headerbtn contenu_headerbtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_pkey PRIMARY KEY (id_contenu_headerbtn);


--
-- Name: contenu_image contenu_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_pkey PRIMARY KEY (id_contenu_image);


--
-- Name: contenu_pave contenu_pave_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_pkey PRIMARY KEY (id_contenu_pave);


--
-- Name: contenu_pdf contenu_pdf_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_pkey PRIMARY KEY (id_contenu_pdf);


--
-- Name: contenu_solobtn contenu_solobtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_pkey PRIMARY KEY (id_contenu_solobtn);


--
-- Name: contenu_texte contenu_texte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_pkey PRIMARY KEY (id_contenu_texte);


--
-- Name: contenu_titre contenu_titre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_pkey PRIMARY KEY (id_contenu_titre);


--
-- Name: page page_page_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_page_url_key UNIQUE (page_url);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id_page);


--
-- Name: pave_bloc pave_bloc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_pkey PRIMARY KEY (id_pave_bloc);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id_section);


--
-- Name: text_index text_index_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_pkey PRIMARY KEY (id_text_index);


--
-- Name: text_index text_index_ref_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_ref_unique UNIQUE (ref_id);


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: idx_text_index_content_plaintext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_text_index_content_plaintext ON public.text_index USING gin (to_tsvector('french'::regconfig, content_plaintext));


--
-- Name: contenu_bandeaubtn update_contenu_bandeaubtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_bandeaubtn_updated_at BEFORE UPDATE ON public.contenu_bandeaubtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_contact update_contenu_contact_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_contact_updated_at BEFORE UPDATE ON public.contenu_contact FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_headerbtn update_contenu_headerbtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_headerbtn_updated_at BEFORE UPDATE ON public.contenu_headerbtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_image update_contenu_image_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_image_updated_at BEFORE UPDATE ON public.contenu_image FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pave update_contenu_pave_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_pave_updated_at BEFORE UPDATE ON public.contenu_pave FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pdf update_contenu_pdf_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_pdf_updated_at BEFORE UPDATE ON public.contenu_pdf FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_solobtn update_contenu_solobtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_solobtn_updated_at BEFORE UPDATE ON public.contenu_solobtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_texte update_contenu_texte_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_texte_updated_at BEFORE UPDATE ON public.contenu_texte FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_titre update_contenu_titre_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_titre_updated_at BEFORE UPDATE ON public.contenu_titre FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: page update_page_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_page_updated_at BEFORE UPDATE ON public.page FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: pave_bloc update_pave_bloc_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_pave_bloc_updated_at BEFORE UPDATE ON public.pave_bloc FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: section update_section_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_section_updated_at BEFORE UPDATE ON public.section FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: text_index update_text_index_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_text_index_updated_at BEFORE UPDATE ON public.text_index FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: utilisateur update_utilisateur_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_utilisateur_updated_at BEFORE UPDATE ON public.utilisateur FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_contact contenu_contact_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_page_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_page_fk_fkey FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_image contenu_image_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pave contenu_pave_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pdf contenu_pdf_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_solobtn contenu_solobtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_texte contenu_texte_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_titre contenu_titre_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: pave_bloc pave_bloc_id_contenu_pave_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_id_contenu_pave_fk FOREIGN KEY (id_contenu_pave_fk) REFERENCES public.contenu_pave(id_contenu_pave) ON DELETE CASCADE;


--
-- Name: section section_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: text_index text_index_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict hD66Cbek08KXupuyze23G9VWTPLSEEuSbZGvWZnUQmb97BigD917uvnkRPVBYC2

