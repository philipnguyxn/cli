import input from '@inquirer/input'
import select from '@inquirer/select'

import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const outputPath = path.resolve(__dirname, '../temp/outputs.txt')

;(async function prompt() {
  const project = await select({
    message: 'Select a project to be created',
    choices: [
      {
        name: 'React  with Tailwind',
        value: 'react',
      },
      {
        name: 'Svelte with Tailwind',
        value: 'svelte',
      },
    ],
  })

  const projectName = await input({ message: "What is the project's name: " })

  const projectPath = await input({
    message: 'Where do you want to create the project at: ',
  })

  // Ensure the directory exists
  fs.mkdirSync(path.resolve(__dirname, '../temp'), { recursive: true })

  // Write the user's choices to the file, each on a new line
  const outputData = `project: ${project}\nname: ${projectName}\npath: ${projectPath}\n`

  fs.writeFileSync(outputPath, outputData)
})()
