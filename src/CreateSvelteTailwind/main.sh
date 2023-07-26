#!/bin/bash

create_svelte_tailwind() {
  project_name=$1

  npm create vite@latest "$project_name" --template svelte-ts
}
