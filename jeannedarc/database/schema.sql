--cette version a été indentée par IA mais créée avec une matrice excel de mon cru: https://docs.google.com/spreadsheets/d/1pwvSUt7iulc7-esofC3Sh7h03Q2OPQbz4eKP8ZntopM/edit?gid=985573600#gid=985573600 

-- Extension pour UUID aléatoires
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Table utilisateur
CREATE TABLE utilisateur (
    id_utilisateur UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    password TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table page
CREATE TABLE page (
    id_page UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    page_url TEXT NOT NULL UNIQUE,
    nom TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table section
CREATE TABLE section (
    id_section UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_page_fk UUID NOT NULL CONSTRAINT section_id_page_fk
        FOREIGN KEY (id_page_fk) REFERENCES page (id_page) ON DELETE CASCADE,
    position SMALLINT NOT NULL,
    type TEXT NOT NULL,
    revert BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_image
CREATE TABLE contenu_image (
    id_contenu_image UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_image_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    lien_vers TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_texte
CREATE TABLE contenu_texte (
    id_contenu_texte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_texte_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    tiptap_content JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_contact
CREATE TABLE contenu_contact (
    id_contenu_contact UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_contact_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    titre TEXT NOT NULL,
    champ1 TEXT NOT NULL,
    champ2 TEXT NOT NULL,
    champ3 TEXT NOT NULL,
    champ4 TEXT NOT NULL,
    bouton TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_pdf
CREATE TABLE contenu_pdf (
    id_contenu_pdf UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_pdf_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    pdf_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_titre
CREATE TABLE contenu_titre (
    id_contenu_titre UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_titre_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    is_mega BOOLEAN NOT NULL DEFAULT FALSE,
    titre1 TEXT,
    titre2 TEXT,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_pave
CREATE TABLE contenu_pave (
    id_contenu_pave UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_pave_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    titre TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_bandeaubtn
CREATE TABLE contenu_bandeaubtn (
    id_contenu_bandeaubtn UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_bandeaubtn_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    icone_url TEXT,
    titre TEXT,
    description TEXT,
    bouton TEXT NOT NULL,
    lien_vers TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table contenu_headerbtn
CREATE TABLE contenu_headerbtn (
    id_contenu_headerbtn UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_section_fk UUID NOT NULL CONSTRAINT contenu_headerbtn_id_section_fk
        FOREIGN KEY (id_section_fk) REFERENCES section (id_section) ON DELETE CASCADE,
    position SMALLINT NOT NULL,
    bouton TEXT NOT NULL,
    lien_vers TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Table pave_bloc
CREATE TABLE pave_bloc (
    id_pave_bloc UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenu_pave_fk UUID NOT NULL CONSTRAINT pave_bloc_id_contenu_pave_fk
        FOREIGN KEY (id_contenu_pave_fk) REFERENCES contenu_pave (id_contenu_pave) ON DELETE CASCADE,
    position SMALLINT NOT NULL,
    icone_url TEXT,
    soustitre TEXT,
    description TEXT,
    lien_vers TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Fonction pour mettre à jour updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers pour toutes les tables
CREATE TRIGGER update_utilisateur_updated_at
BEFORE UPDATE ON utilisateur
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_page_updated_at
BEFORE UPDATE ON page
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_section_updated_at
BEFORE UPDATE ON section
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_image_updated_at
BEFORE UPDATE ON contenu_image
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_texte_updated_at
BEFORE UPDATE ON contenu_texte
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_contact_updated_at
BEFORE UPDATE ON contenu_contact
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_pdf_updated_at
BEFORE UPDATE ON contenu_pdf
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_titre_updated_at
BEFORE UPDATE ON contenu_titre
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_pave_updated_at
BEFORE UPDATE ON contenu_pave
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_bandeaubtn_updated_at
BEFORE UPDATE ON contenu_bandeaubtn
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contenu_headerbtn_updated_at
BEFORE UPDATE ON contenu_headerbtn
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_pave_bloc_updated_at
BEFORE UPDATE ON pave_bloc
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
