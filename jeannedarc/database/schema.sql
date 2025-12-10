-- Extension pour UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Table TEXTSECTION
CREATE TABLE IF NOT EXISTS TEXTSECTION (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- génération automatique d'un UUID
    url TEXT NOT NULL UNIQUE,
    content JSONB NOT NULL, -- JSONB est plus performant pour requêtes / indexation
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Optionnel : trigger pour mettre à jour updated_at à chaque modification
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_textsection_updated_at
BEFORE UPDATE ON TEXTSECTION
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();