"use client";

import { useRef } from "react";
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
import { Spacer } from "@/components/tiptap-ui-primitive/spacer";
import {
    Toolbar,
    ToolbarGroup,
    ToolbarSeparator,
} from "@/components/tiptap-ui-primitive/toolbar";

// --- Tiptap Node ---
import { HorizontalRule } from "@/components/tiptap-node/horizontal-rule-node/horizontal-rule-node-extension";
import "@/components/tiptap-node/blockquote-node/blockquote-node.scss";
import "@/components/tiptap-node/code-block-node/code-block-node.scss";
import "@/components/tiptap-node/horizontal-rule-node/horizontal-rule-node.scss";
import "@/components/tiptap-node/list-node/list-node.scss";
import "@/components/tiptap-node/image-node/image-node.scss";
import "@/components/tiptap-node/heading-node/heading-node.scss";
import "@/components/tiptap-node/paragraph-node/paragraph-node.scss";

// --- Tiptap UI ---
import { HeadingDropdownMenu } from "@/components/tiptap-ui/heading-dropdown-menu";
import { BlockquoteButton } from "@/components/tiptap-ui/blockquote-button";
import { ColorHighlightPopover } from "@/components/tiptap-ui/color-highlight-popover";
import { LinkPopover } from "@/components/tiptap-ui/link-popover";
import { MarkButton } from "@/components/tiptap-ui/mark-button";
import { TextAlignButton } from "@/components/tiptap-ui/text-align-button";
import { UndoRedoButton } from "@/components/tiptap-ui/undo-redo-button";
import { ListButton } from "@/components/tiptap-ui/list-button";

// --- Components ---
import { ThemeToggle } from "@/components/tiptap-templates/simple/theme-toggle";

// --- Styles ---
import "@/components/tiptap-templates/simple/simple-editor.scss";

import content from "@/components/tiptap-templates/simple/data/content.json";
import { updateTextSectionByUrl, updateTextSectionByUrlString } from "@/lib/contentCrud";
import { TextColorPopover } from "@/components/tiptap-ui/text-color-popover/text-color-popover";

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

export function SimpleEditor() {
    const toolbarRef = useRef<HTMLDivElement>(null);

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
        content, //initial content
    });

function handleSave() {
    const json = editor!.getJSON();
    
    // Stringify pour bypasser la sérialisation Next.js
    const jsonString = JSON.stringify(json);
    updateTextSectionByUrlString(jsonString, "projet-pedagogique");
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
                SAVE
            </button>

        </>
    );
}
