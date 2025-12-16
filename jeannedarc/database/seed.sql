-- 1️⃣ Créer la page
INSERT INTO page (id_page, page_url, nom, created_at, updated_at)
VALUES (
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'projets/projet-pedagogique',
    'Projet Pédagogique',
    NOW(),
    NOW()
);

-- 2️⃣ Créer les sections (dans l'ordre chronologique)
INSERT INTO section (id_section, id_page_fk, type, revert, created_at, updated_at)
VALUES
(
    '019b275a-6ae0-79d6-9ed0-a94a8024a60b',
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'Titre',
    FALSE,
    NOW(),
    NOW()
),
(
    '019b275a-6ae0-7b29-a199-066e1fe3b011',
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'ImageTexte',
    TRUE,
    NOW(),
    NOW()
),
(
    '019b275a-6ae0-74ba-9888-41128454f438',
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'Texte',
    FALSE,
    NOW(),
    NOW()
);

-- 3️⃣ Créer le contenu_titre
INSERT INTO contenu_titre (id_contenu_titre, id_section_fk, is_mega, titre1, titre2, description, created_at, updated_at)
VALUES (
    '019b275a-6ae0-7ba1-a704-13ebbf13a3ee',
    '019b275a-6ae0-79d6-9ed0-a94a8024a60b',
    FALSE,
    'PROJET PÉDAGOGIQUE',
    'PROJET PÉDAGOGIQUE',
    '',
    NOW(),
    NOW()
);

-- 4️⃣ Créer les contenus_texte
INSERT INTO contenu_texte (id_contenu_texte, id_section_fk, tiptap_content, created_at, updated_at)
VALUES
(
    '019b275a-6ae0-7434-9589-195613001f14',
    '019b275a-6ae0-7b29-a199-066e1fe3b011',
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
),
(
    '019b275a-6ae0-74d5-9228-bd57ac07d0f7',
    '019b275a-6ae0-74ba-9888-41128454f438',
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
);
