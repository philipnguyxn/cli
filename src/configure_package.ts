import fs from 'fs'
import path from 'path'
import appRoot from 'app-root-path'

// Read the data from outputs.txt
const outputsData = fs.readFileSync('../temp/outputs.txt', {
  encoding: 'utf8',
  flag: 'r',
})

// Extract the actual path to the project
const lines = outputsData.split('\n')
let projectPath = ''
let projectName = ''

for (const line of lines) {
  const parts = line.split(': ')

  if (parts[0] === 'path') {
    projectPath = parts[1]
  } else if (parts[0] === 'name') {
    projectName = parts[1]
  }
}

// Load the JSON data from the absolute path to the project's package.json
const data = JSON.parse(
  fs.readFileSync(
    path.join(appRoot.path, `${projectPath}/${projectName}/package.json`),
    {
      encoding: 'utf8',
      flag: 'r',
    }
  )
)

// Modify the data
data.scripts.lint = 'eslint --ignore-path .gitignore --ext .js,.ts,.svelte .'
data.scripts.format =
  'prettier --ignore-path .gitignore --ext .js,.ts,.svelte .'

// Write the data back to the file
fs.writeFileSync('package.json', JSON.stringify(data, null, 2))
