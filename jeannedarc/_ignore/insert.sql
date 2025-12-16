INSERT INTO section (id_section, id_page_fk, type, revert, created_at, updated_at)
VALUES
(
    '019b275a-6ae0-70c2-b0e4-7660e1492690',
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'ImageTexte',
    TRUE,
    NOW(),
    NOW()
),
(
    '019b275a-6ae0-7862-9287-0656e78252a7',
    '019b275a-6ae0-7aef-9d7d-4f0352c5e351',
    'Texte',
    FALSE,
    NOW(),
    NOW()
);

INSERT INTO contenu_texte (id_contenu_texte, id_section_fk, tiptap_content, created_at, updated_at)
VALUES
(
    '019b279a-235e-7813-b2f2-e988ebb636d6',
    '019b275a-6ae0-70c2-b0e4-7660e1492690',
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
),
(
    '019b279a-235e-703e-bd2f-34840f3d2c19',
    '019b275a-6ae0-7862-9287-0656e78252a7',
    '{"type": "doc", "content": [{"type": "paragraph", "content": [{"text": "(vide)", "type": "text"}]}]}',
    NOW(),
    NOW()
);