"use client";
import { useState } from "react";
import {DisplayedText} from "@/components/DisplayedText/DisplayedText";

export default function Page() {
    const [text, setText] = useState("");

    return (
        <div className="p-8">
                        <DisplayedText />
        </div>
    );
}
