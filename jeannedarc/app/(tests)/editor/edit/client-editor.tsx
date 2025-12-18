"use client";

import dynamic from "next/dynamic"; // Next.js fournit dynamic()
// pour importer un module au runtime dans le navigateur.

const ContenuTexteEdit = dynamic(
    () =>
        import(
            "@/components/tiptap/tiptap-templates/simple/simple-editor"
        ).then((mod) => mod.ContenuTexteEdit),
    { ssr: false }
);

export default function ClientEditor() {
    return (
        <>
            <ContenuTexteEdit />
        </>
    );
}
