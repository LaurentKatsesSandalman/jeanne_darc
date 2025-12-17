-- 1️⃣ Créer la page
INSERT INTO page ( page_url, nom, created_at, updated_at)
VALUES (
    
    'projets/projet-pedagogique',
    'Projet Pédagogique',
    NOW(),
    NOW()
);

-- 2️⃣ Créer les sections (dans l'ordre chronologique)
INSERT INTO section ( id_page_fk, type, revert, created_at, updated_at)
VALUES
(
    
    'e11935b9-f19d-41ee-a061-d3f9bd26afde',
    'Titre',
    FALSE,
    NOW(),
    NOW()
);
INSERT INTO section ( id_page_fk, type, revert, created_at, updated_at)
VALUES
(
    
    'e11935b9-f19d-41ee-a061-d3f9bd26afde',
    'ImageTexte',
    TRUE,
    NOW(),
    NOW()
);
INSERT INTO section ( id_page_fk, type, revert, created_at, updated_at)
VALUES
(
    
    'e11935b9-f19d-41ee-a061-d3f9bd26afde',
    'Texte',
    FALSE,
    NOW(),
    NOW()
);

-- 3️⃣ Créer le contenu_titre
INSERT INTO contenu_titre ( id_section_fk, is_mega, titre1, titre2, description, created_at, updated_at)
VALUES (
    
    'b1386907-04fd-4e23-b527-200f3204653e',
    FALSE,
    'PROJET PÉDAGOGIQUE',
    'PROJET PÉDAGOGIQUE',
    '',
    NOW(),
    NOW()
);

-- 4️⃣ Créer les contenus_texte
INSERT INTO contenu_texte (id_section_fk, tiptap_content, created_at, updated_at)
VALUES
(
    
    '610a236a-6c92-46e1-b281-41060ac503e8',
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
),
(
    '2e5b0548-c923-45c8-80b5-6e045a4877f5',
	
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
);

INSERT INTO contenu_image ( id_section_fk, image_url, alt_text, created_at, updated_at)
VALUES
(
	'610a236a-6c92-46e1-b281-41060ac503e8',
	'https://www.jeannedarc33.fr/wp-content/uploads/2023/04/Projet-Pedagogique-et-Pastoral-ENCADRE.png',
	'Schéma projet pédagogique et pastoral',
	NOW(),
    NOW()
)
