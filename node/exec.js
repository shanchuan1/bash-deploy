const { exec } = require("child_process");

const execProcess = async () => {
  await exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error(`Failed to run 'yarn install' in ${repo.url}:`, error);
      return;
    }
    console.log(`Yarn install output for ${repo.url}: ${stdout}`);
    if (stderr) console.error(`Yarn install errors for ${repo.url}: ${stderr}`);
  });
};



module.exports = {
    execProcess
}