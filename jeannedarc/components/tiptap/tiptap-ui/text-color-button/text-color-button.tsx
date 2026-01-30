"use client";

import { forwardRef } from "react";
import { type Editor } from "@tiptap/react";
import {
    Button,
    type ButtonProps,
} from "@/components/tiptap/tiptap-ui-primitive/button";
import { PaintbrushIcon } from "lucide-react"; // ou ton icône

export interface TextColor {
    label: string;
    value: string;
}

export interface UseTextColorConfig {
    editor?: Editor | null;
    hideWhenUnavailable?: boolean;
    onApplied?: () => void;
}

export interface TextColorButtonProps extends Omit<ButtonProps, "type"> {
    editor?: Editor | null;
    textColor: string;
    tooltip?: string;
}

// Helper pour créer des couleurs prédéfinies
export function pickTextColorsByValue(values: string[]): TextColor[] {
    const colorMap: Record<string, string> = {
        "#17383e": "Défaut",
        "#c24322": "Rouge-orange",
        "#638a8c": "Vert foncé",
        "#4eb169": "Vert clair",
        "#f6ae3b": "Jaune",
        "#5b8fc7": "Bleu",
        "#10292e": "Bleu foncé",
    };

    return values.map((value) => ({
        label: colorMap[value] || value,
        value,
    }));
}

// Hook personnalisé pour gérer la couleur de texte
export function useTextColor({
    editor,
    hideWhenUnavailable = false,
    onApplied,
}: UseTextColorConfig) {
    const canSetTextColor = editor?.can().setColor("#000000") ?? false;
    const isActive = editor?.isActive("textStyle") ?? false;
    const currentColor = editor?.getAttributes("textStyle").color || "#000000";

    const handleRemoveTextColor = () => {
        if (!editor) return;
        editor.chain().focus().unsetColor().run();
        onApplied?.();
    };

    const handleSetTextColor = (color: string) => {
        if (!editor) return;
        editor.chain().focus().setColor(color).run();
        onApplied?.();
    };

    return {
        isVisible: hideWhenUnavailable ? canSetTextColor : true,
        canSetTextColor,
        isActive,
        currentColor,
        label: "Text color",
        Icon: PaintbrushIcon,
        handleRemoveTextColor,
        handleSetTextColor,
    };
}

// Bouton individuel de couleur
export const TextColorButton = forwardRef<
    HTMLButtonElement,
    TextColorButtonProps
>(({ editor, textColor, tooltip, className, ...props }, ref) => {
    const { handleSetTextColor, currentColor } = useTextColor({ editor });
    const isActive = currentColor === textColor;

    return (
        <Button
            type="button"
            onClick={() => handleSetTextColor(textColor)}
            className={className}
            data-style="ghost"
            data-appearance="default"
            data-active-state={isActive ? "on" : "off"}
            role="button"
            tabIndex={-1}
            aria-label={tooltip || `${textColor} text color`}
            tooltip={tooltip}
            ref={ref}
            {...props}
        >
            <div
                style={{
                    width: "16px",
                    height: "16px",
                    backgroundColor: textColor,
                    border: "1px solid var(--tt-color-border)",
                    borderRadius: "2px",
                }}
            />
        </Button>
    );
});

TextColorButton.displayName = "TextColorButton";
