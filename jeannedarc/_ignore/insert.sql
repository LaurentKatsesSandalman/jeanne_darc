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

INSERT INTO contenu_image (id_contenu_image, id_section_fk, image_url, alt_text, created_at, updated_at)
VALUES
(
	'019b2b8a-fb36-7887-a0be-9a90bb1b7d31',
	'019b275a-6ae0-70c2-b0e4-7660e1492690',
	'https://drive.google.com/file/d/12SB1sI6shPnnYDarlhZxeJwc6XAs5UP0/view?usp=sharing',
	'Image vide',
	NOW(),
    NOW()
),
(
	'019b2b8a-fb36-7ccc-a3ce-e092c167fea9',
	'019b275a-6ae0-70c2-b0e4-7660e1492690',
	'https://drive.google.com/file/d/12SB1sI6shPnnYDarlhZxeJwc6XAs5UP0/view?usp=sharing',
	'Image vide',
	NOW(),
    NOW()
);

DELETE from contenu_image where id_contenu_image = '019b2b8a-fb36-7887-a0be-9a90bb1b7d31';

INSERT INTO contenu_image (id_contenu_image, id_section_fk, image_url, alt_text, created_at, updated_at)
VALUES
(
	'019b2b8a-fb36-7887-a0be-9a90bb1b7d31',
	'019b275a-6ae0-7b29-a199-066e1fe3b011',
	'https://drive.google.com/file/d/12SB1sI6shPnnYDarlhZxeJwc6XAs5UP0/view?usp=sharing',
	'Image vide',
	NOW(),
    NOW()
)