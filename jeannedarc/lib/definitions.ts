import type { JSONContent } from '@tiptap/core';

export type ContenuTipTap = JSONContent;

export interface InterfacePage {
	id: string;
	url: string;
	content: ContenuTipTap;
	created_at: string;
	updated_at: string;
}