"use client";

import EditableText from "@/app/common/components/EditableText";
import { useState } from "react";
import { SimpleEditor } from "@/components/tiptap-templates/simple/simple-editor";

export default function Page() {
    const [text, setText] = useState("");

    return (
        <div className="p-8">
            <h2 className="text-2xl font-bold mb-4">Test Tiptap</h2>
            <EditableText value={text} onChange={setText} />

            {/* Pour voir le HTML généré */}
            <div className="mt-4">
                <h2 className="font-bold">HTML généré :</h2>
                <pre className="bg-gray-100 p-4 rounded mt-2 text-xs overflow-auto">
                    {text}
                </pre>
            </div>
            <h2 className="text-2xl font-bold mb-4">Test tiptap simple editor</h2>
            <SimpleEditor />
        </div>
    );
}
