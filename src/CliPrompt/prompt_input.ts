import input from '@inquirer/input'

const projectName = await input({ message: "What is the project's name: " })

console.log(projectName)

const projectDirectory = await input({
  message: 'Where do you want to create the project at: ',
})

console.log(projectDirectory)
