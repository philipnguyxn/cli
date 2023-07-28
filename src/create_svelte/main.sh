#!/bin/bash

configure_eslint() {
  original_dir=$1

  npm i -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-config-prettier eslint-plugin-svelte

  cat <<EOF >./.eslintrc.json
{
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json",
    "extraFileExtensions": [".svelte"]
  },
  "plugins": ["@typescript-eslint"],
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended", "plugin:svelte/prettier", "prettier"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/consistent-type-definitions": ["error", "type"]
  },
  "overrides": [
    {
      "files": ["*.svelte"],
      "parser": "svelte-eslint-parser",
      "parserOptions": {
        "parser": "@typescript-eslint/parser",
      }
    }
  ],
  "env": {
    "browser": true,
    "es2021": true
  }
}
EOF

  eslintignore_config="
    node_modules
    dist
    "

  touch .eslintignore

  echo -e "$eslintignore_config" || cat >.eslintignore

  node "$original_dir"/dist/configure_package.js
}
original_dir=$1

configure_prettier() {
  original_dir=$1

  npm i -D prettier prettier-plugin-tailwindcss @trivago/prettier-plugin-sort-imports prettier-plugin-svelte
}

create_svelte_project() {
  path=$1
  name=$2

  original_dir=$(pwd)

  cd "$path" || exit

  npm create vite@latest "$name" -- --template svelte-ts

  cd "$name" || exit

  npm install

  configure_eslint "$original_dir"

  configure_prettier "$original_dir"

  # code .

  # npm run dev
}
