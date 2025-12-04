"use client";

import { useEditor, EditorContent } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import TextAlign from "@tiptap/extension-text-align";
import Underline from "@tiptap/extension-underline";
import Superscript from "@tiptap/extension-superscript";
import Subscript from "@tiptap/extension-subscript";
import Link from "@tiptap/extension-link";
import FontFamily from "@tiptap/extension-font-family";
import { TextStyle } from "@tiptap/extension-text-style";
import { useEffect } from "react";
import "./EditableText.css";
// Extension personnalisée pour la taille de police
import { Extension } from "@tiptap/core";

import { 
  AlignLeft, 
  AlignCenter, 
  AlignRight, 
  AlignJustify,
  Bold,
  Italic,
  Underline as UnderlineIcon,
  List,
  ListOrdered,
  Link as LinkIcon,
  ListIndentDecrease,
  ListIndentIncrease,
  Superscript as SuperscriptIcon,
  Subscript as SubscriptIcon
} from "lucide-react";

const FontSize = Extension.create({
  name: "fontSize",
  addOptions() {
    return {
      types: ["textStyle"],
    };
  },
  addGlobalAttributes() {
    return [
      {
        types: this.options.types,
        attributes: {
          fontSize: {
            default: null,
            parseHTML: (element) => element.style.fontSize.replace("px", ""),
            renderHTML: (attributes) => {
              if (!attributes.fontSize) {
                return {};
              }
              return {
                style: `font-size: ${attributes.fontSize}px`,
              };
            },
          },
        },
      },
    ];
  },
});

interface EditableTextProps {
  value: string;
  onChange: (html: string) => void;
}

const FONT_FAMILIES = [
  { label: "Texte", value: `-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol"` },
  { label: "Titre", value: `"IBM Plex Serif", serif` },
  { label: "Citations", value: "Georgia, serif" },
  { label: "Formaté", value: "monospace" },
];

const FONT_SIZES = ["12", "14", "15", "16", "18", "20", "25", "30", "35", "40"];

export default function EditableText({ value, onChange }: EditableTextProps) {
  const editor = useEditor({
	immediatelyRender: false,
    extensions: [
      StarterKit.configure({
        heading: false,
      }),
      TextAlign.configure({
        types: ["heading", "paragraph"],
        alignments: ["left", "center", "right", "justify"],
      }),
      Underline,
      Superscript,
      Subscript,
      Link.configure({
        openOnClick: false,
        HTMLAttributes: {
          class: "text-blue-600 underline",
        },
      }),
      FontFamily,
      TextStyle, // ← Sans accolades maintenant
      FontSize,
    ],
    content: value,
    onUpdate: ({ editor }) => {
      onChange(editor.getHTML());
    },
  });

  useEffect(() => {
    if (editor && value !== editor.getHTML()) {
      editor.commands.setContent(value);
    }
  }, [value, editor]);

  if (!editor) {
    return null;
  }

  const setLink = () => {
    const url = window.prompt("URL du lien:");
    if (url) {
      editor.chain().focus().setLink({ href: url }).run();
    }
  };

  const setFontSize = (size: string) => {
    editor.chain().focus().setMark("textStyle", { fontSize: size }).run();
  };

  const setFontFamily = (font: string) => {
    editor.chain().focus().setFontFamily(font).run();
  };

  return (
    <div className="tiptap-editor">
      {/* Toolbar */}
      <div className="toolbar">
        {/* Police */}
        <select
          onChange={(e) => setFontFamily(e.target.value)}
          className="toolbar-select"
          style={{ fontFamily: "inherit" }}
        >
          <option value="">Police</option>
          {FONT_FAMILIES.map((font) => (
            <option key={font.value} value={font.value} style={{ fontFamily: font.value }}>
              {font.label}
            </option>
          ))}
        </select>

        {/* Taille */}
        <select
          onChange={(e) => setFontSize(e.target.value)}
          className="toolbar-select"
        >
          <option value="">Taille</option>
          {FONT_SIZES.map((size) => (
            <option key={size} value={size}>
              {size}
            </option>
          ))}
        </select>

        <div className="toolbar-divider" />

        {/* Formatage texte */}
        <button
          onClick={() => editor.chain().focus().toggleBold().run()}
          className={editor.isActive("bold") ? "is-active" : ""}
          title="Gras (Ctrl+B)"
        >
          <Bold size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().toggleItalic().run()}
          className={editor.isActive("italic") ? "is-active" : ""}
          title="Italique (Ctrl+I)"
        >
          <Italic size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().toggleUnderline().run()}
          className={editor.isActive("underline") ? "is-active" : ""}
          title="Souligné (Ctrl+U)"
        >
          <UnderlineIcon size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().toggleSuperscript().run()}
          className={editor.isActive("superscript") ? "is-active" : ""}
          title="Exposant"
        >
          <SuperscriptIcon size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().toggleSubscript().run()}
          className={editor.isActive("subscript") ? "is-active" : ""}
          title="Indice"
        >
          <SubscriptIcon size={16} />
        </button>

        <div className="toolbar-divider" />

        {/* Alignement */}
        <button
          onClick={() => editor.chain().focus().setTextAlign("left").run()}
          className={editor.isActive({ textAlign: "left" }) ? "is-active" : ""}
          title="Aligner à gauche"
        >
          <AlignLeft size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().setTextAlign("center").run()}
          className={editor.isActive({ textAlign: "center" }) ? "is-active" : ""}
          title="Centrer"
        >
          <AlignCenter size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().setTextAlign("right").run()}
          className={editor.isActive({ textAlign: "right" }) ? "is-active" : ""}
          title="Aligner à droite"
        >
          <AlignRight size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().setTextAlign("justify").run()}
          className={editor.isActive({ textAlign: "justify" }) ? "is-active" : ""}
          title="Justifier"
        >
          <AlignJustify size={16} />
        </button>

        <div className="toolbar-divider" />

        {/* Listes */}
        <button
          onClick={() => editor.chain().focus().toggleBulletList().run()}
          className={editor.isActive("bulletList") ? "is-active" : ""}
          title="Liste à puces"
        >
          <List size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().toggleOrderedList().run()}
          className={editor.isActive("orderedList") ? "is-active" : ""}
          title="Liste numérotée"
        >
          <ListOrdered size={16} />
        </button>

        {/* Indentation */}
        <button
          onClick={() => editor.chain().focus().sinkListItem("listItem").run()}
          disabled={!editor.can().sinkListItem("listItem")}
          title="Augmenter le retrait"
        >
          <ListIndentIncrease size={16} />
        </button>
        <button
          onClick={() => editor.chain().focus().liftListItem("listItem").run()}
          disabled={!editor.can().liftListItem("listItem")}
          title="Diminuer le retrait"
        >
          <ListIndentDecrease size={16} />
        </button>

        <div className="toolbar-divider" />

        {/* Lien */}
        <button
          onClick={setLink}
          className={editor.isActive("link") ? "is-active" : ""}
          title="Insérer un lien"
        >
          <LinkIcon size={16} />
        </button>
        {editor.isActive("link") && (
          <button
            onClick={() => editor.chain().focus().unsetLink().run()}
            title="Supprimer le lien"
          >
            ✕
          </button>
        )}
      </div>

      {/* Éditeur */}
      <EditorContent editor={editor} className="editor-content" />
    </div>
  );
}