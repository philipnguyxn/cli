#!/bin/bash

configure_eslint_prettier() {
  is_configuring_eslint=$1

  if [[ $is_configuring_eslint ]]; then
    echo "is eslint"
  else
    echo "is prettier"
  fi
}

create_svelte_tailwind() {
  path=$1
  name=$2

  cd "$path" || exit

  npm create vite@latest "$name" -- --template svelte-ts

  cd "$name" || exit

  npm install

  configure_eslint_prettier true

  code .

  npm run dev
}
