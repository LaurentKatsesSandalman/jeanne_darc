"use client";

import dynamic from "next/dynamic"; // Next.js fournit dynamic()
// pour importer un module au runtime dans le navigateur.

const SimpleEditor = dynamic(
    () =>
        import(
            "@/components/tiptap/tiptap-templates/simple/simple-editor"
        ).then((mod) => mod.SimpleEditor),
    { ssr: false }
);

export default function ClientEditor() {
    return (
        <>
            <SimpleEditor />
        </>
    );
}
