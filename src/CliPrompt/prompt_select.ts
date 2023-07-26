import select from '@inquirer/select';

const answer = await select({
  message: 'Select a project to be created',
  choices: [
    {
      name: 'React-TS with Tailwind',
      value: 'react',
    },
    {
      name: 'Svelte-TS with Tailwind',
      value: 'svelte',
    },
  ],
});

console.log(answer)