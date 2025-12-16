"use client";

import { SetStateAction, useRef, Dispatch } from "react";
import { EditorContent, EditorContext, useEditor } from "@tiptap/react";

// --- Tiptap Core Extensions ---
import { StarterKit } from "@tiptap/starter-kit";
//import { Image } from "@tiptap/extension-image"
import { TaskItem, TaskList } from "@tiptap/extension-list";
import { TextAlign } from "@tiptap/extension-text-align";
import { Typography } from "@tiptap/extension-typography";
import { Highlight } from "@tiptap/extension-highlight";
import { Subscript } from "@tiptap/extension-subscript";
import { Superscript } from "@tiptap/extension-superscript";
import { Selection } from "@tiptap/extensions";
import { TextStyle } from "@tiptap/extension-text-style";
import { Color } from "@tiptap/extension-color";

// --- UI Primitives ---
import { Spacer } from "@/components/tiptap/tiptap-ui-primitive/spacer";
import {
    Toolbar,
    ToolbarGroup,
    ToolbarSeparator,
} from "@/components/tiptap/tiptap-ui-primitive/toolbar";

// --- Tiptap Node ---
import { HorizontalRule } from "@/components/tiptap/tiptap-node/horizontal-rule-node/horizontal-rule-node-extension";
import "@/components/tiptap/tiptap-node/blockquote-node/blockquote-node.scss";
import "@/components/tiptap/tiptap-node/code-block-node/code-block-node.scss";
import "@/components/tiptap/tiptap-node/horizontal-rule-node/horizontal-rule-node.scss";
import "@/components/tiptap/tiptap-node/list-node/list-node.scss";
import "@/components/tiptap/tiptap-node/image-node/image-node.scss";
import "@/components/tiptap/tiptap-node/heading-node/heading-node.scss";
import "@/components/tiptap/tiptap-node/paragraph-node/paragraph-node.scss";

// --- Tiptap UI ---
import { HeadingDropdownMenu } from "@/components/tiptap/tiptap-ui/heading-dropdown-menu";
import { BlockquoteButton } from "@/components/tiptap/tiptap-ui/blockquote-button";
import { ColorHighlightPopover } from "@/components/tiptap/tiptap-ui/color-highlight-popover";
import { LinkPopover } from "@/components/tiptap/tiptap-ui/link-popover";
import { MarkButton } from "@/components/tiptap/tiptap-ui/mark-button";
import { TextAlignButton } from "@/components/tiptap/tiptap-ui/text-align-button";
import { UndoRedoButton } from "@/components/tiptap/tiptap-ui/undo-redo-button";
import { ListButton } from "@/components/tiptap/tiptap-ui/list-button";

// --- Components ---
import { ThemeToggle } from "@/components/tiptap/tiptap-templates/simple/theme-toggle";

// --- Styles ---
import "@/components/tiptap/tiptap-templates/simple/simple-editor.scss";

//import content from "@/components/tiptap/tiptap-templates/simple/data/content.json";
import { TextColorPopover } from "@/components/tiptap/tiptap-ui/text-color-popover/text-color-popover";
import { ContenuTexteInterface } from "@/lib/schemas";
import { usePathname } from "next/navigation";
import { updateContenuTexteAction } from "@/lib/actions/actionsContenu";
import { CloseCancelIcon, SaveIcon } from "@/components/Icons/Icons";

const MainToolbarContent = () => {
    return (
        <>
            <Spacer />

            <ToolbarGroup>
                <UndoRedoButton action="undo" />
                <UndoRedoButton action="redo" />
            </ToolbarGroup>

            <ToolbarSeparator />

            <ToolbarGroup>
                <HeadingDropdownMenu levels={[1, 2, 3, 4, 5]} portal={true} />
                <ListButton type="bulletList" />
                <ListButton type="orderedList" />
                <BlockquoteButton />
            </ToolbarGroup>

            <ToolbarSeparator />

            <ToolbarGroup>
                <MarkButton type="bold" />
                <MarkButton type="italic" />
                <MarkButton type="underline" />
                <ColorHighlightPopover />
                <TextColorPopover />
                <LinkPopover />
            </ToolbarGroup>

            <ToolbarSeparator />

            <ToolbarGroup>
                <MarkButton type="superscript" />
                <MarkButton type="subscript" />
            </ToolbarGroup>

            <ToolbarSeparator />

            <ToolbarGroup>
                <TextAlignButton align="left" />
                <TextAlignButton align="center" />
                <TextAlignButton align="right" />
                <TextAlignButton align="justify" />
            </ToolbarGroup>

            <Spacer />

            <ToolbarGroup>
                <ThemeToggle />
            </ToolbarGroup>
        </>
    );
};

interface ContenuTexteEditProps {
    contenu: ContenuTexteInterface;
	setEditTexte: Dispatch<SetStateAction<boolean>>
}

export function ContenuTexteEdit({ contenu, setEditTexte }: ContenuTexteEditProps) {
    const toolbarRef = useRef<HTMLDivElement>(null);
    const url = usePathname();

    const editor = useEditor({
        immediatelyRender: false,
        editorProps: {
            attributes: {
                autocomplete: "off",
                autocorrect: "off",
                autocapitalize: "off",
                "aria-label": "Main content area, start typing to enter text.",
                class: "simple-editor",
            },
        },
        extensions: [
            StarterKit.configure({
                horizontalRule: false,
                link: {
                    openOnClick: false,
                    enableClickSelection: true,
                },
            }),
            TextStyle.configure({
                // Ajoute ceci pour forcer la préservation des attrs
                HTMLAttributes: {},
            }),
            Color.configure({
                types: ["textStyle"],
            }),
            HorizontalRule,
            TextAlign.configure({ types: ["heading", "paragraph"] }),
            TaskList,
            TaskItem.configure({ nested: true }),
            Highlight.configure({ multicolor: true }),
            //   Image,
            Typography,
            Superscript,
            Subscript,
            Selection,
            //   ImageUploadNode.configure({
            //     accept: "image/*",
            //     maxSize: MAX_FILE_SIZE,
            //     limit: 3,
            //     upload: handleImageUpload,
            //     onError: (error) => console.error("Upload failed:", error),
            //   }),
        ],
        content: contenu.tiptap_content, //initial content
    });

    async function handleSave() {
        const json = editor!.getJSON();

        // Stringify pour bypasser la sérialisation Next.js
        const jsonString = JSON.stringify(json);
        const result = await updateContenuTexteAction(contenu.id_contenu_texte, {tiptap_content:jsonString},  url);

		if (!result.success) {
			setEditTexte(false);
            throw new Error("error" in result ? result.error : "Validation error");
        }

		setEditTexte(false);
    }

    return (
        <>
            <div className="simple-editor-wrapper">
                <EditorContext.Provider value={{ editor }}>
                    <Toolbar ref={toolbarRef}>
                        <MainToolbarContent />
                    </Toolbar>

                    <EditorContent
                        editor={editor}
                        role="presentation"
                        className="simple-editor-content"
                    />
                </EditorContext.Provider>
            </div>
            <button
                onClick={handleSave}
                className="bg-blue-500 text-white font-bold py-2 px-4 rounded shadow-lg hover:bg-blue-700"
            >
                <SaveIcon/>
            </button>
			<button
                onClick={()=>setEditTexte(false)}
                className="bg-blue-500 text-white font-bold py-2 px-4 rounded shadow-lg hover:bg-blue-700"
            >
                <CloseCancelIcon/>
            </button>
        </>
    );
}
