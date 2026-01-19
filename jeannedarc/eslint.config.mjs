import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
// adding rules
  {
    rules: {
      "no-unused-vars": [
        "error",
        {
          varsIgnorePattern: "^_$",  // Ignore uniquement la variable `_`
          argsIgnorePattern: "^_$", // Ignore uniquement l'argument `_`
        },
      ],
    },
  },

  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
	"_ignore/**",
	"components/tiptap/**",
	"lib/tiptap-utils.ts",
	"hooks/**" // all from tip-tap
  ]),
]);

export default eslintConfig;
