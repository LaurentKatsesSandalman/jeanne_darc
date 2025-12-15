"use client";

import { useEditor, EditorContent } from "@tiptap/react";

// --- Tiptap Core Extensions ---
import { StarterKit } from "@tiptap/starter-kit";
import { TaskItem, TaskList } from "@tiptap/extension-list";
import { TextAlign } from "@tiptap/extension-text-align";
import { Typography } from "@tiptap/extension-typography";
import { Highlight } from "@tiptap/extension-highlight";
import { Subscript } from "@tiptap/extension-subscript";
import { Superscript } from "@tiptap/extension-superscript";
import { TextStyle } from "@tiptap/extension-text-style";
import { Color } from "@tiptap/extension-color";

// --- Styles (mêmes que l'éditeur) ---
import "@/components/tiptap/tiptap-node/blockquote-node/blockquote-node.scss";
import "@/components/tiptap/tiptap-node/code-block-node/code-block-node.scss";
import "@/components/tiptap/tiptap-node/horizontal-rule-node/horizontal-rule-node.scss";
import "@/components/tiptap/tiptap-node/list-node/list-node.scss";
// import "@/components/tiptap/tiptap-node/image-node/image-node.scss"
import "@/components/tiptap/tiptap-node/heading-node/heading-node.scss";
import "@/components/tiptap/tiptap-node/paragraph-node/paragraph-node.scss";

// --- Data ---
import defaultContent from "@/components/tiptap/tiptap-templates/simple/data/content.json";
import { ContenuTipTap } from "@/lib/schemas";

interface Debugprops {
    contenu: ContenuTipTap;
}

export function ContenuTexte({ contenu = defaultContent }: Debugprops) {
    const editor = useEditor({
        immediatelyRender: false,
        editable: false, // Mode lecture seule
        editorProps: {
            attributes: {
                class: "simple-editor", // Même classe CSS que l'éditeur
            },
        },
        extensions: [
            StarterKit.configure({
                horizontalRule: false,
            }),
            TextStyle, // +++
            Color.configure({
                types: ["textStyle"],
            }),
            TextAlign.configure({ types: ["heading", "paragraph"] }),
            TaskList,
            TaskItem.configure({ nested: true }),
            Highlight.configure({ multicolor: true }),
            //   Image,
            Typography,
            Superscript,
            Subscript,
        ],
        content: contenu,
    });

    return (
        <div className="simple-editor-viewer">
            <EditorContent editor={editor} className="simple-editor-content" />
        </div>
    );
}
