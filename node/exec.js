const { exec } = require("child_process");
const { greenLog} = require('./terminalLog')

global.DEFAULT_PACKAGE_MANAGER = "yarn";

const packManager = {
  yarn: {
    INSTALL: (repo) => `cd ${repo.dest} && yarn`,
    BUILD: (repo) => `cd ${repo.dest} && yarn build`,
  },
  npm: {
    INSTALL: (repo) => `cd ${repo.dest} && npm run install`,
    BUILD: (repo) => `cd ${repo.dest} && npm run build`,
  },
  pnpm: {
    INSTALL: (repo) => `cd ${repo.dest} && pnpm install`,
    BUILD: (repo) => `cd ${repo.dest} && pnpm run build`,
  },
};

const execLog = (command, repo) => {
  return (stdout) => {
    command === "INSATLL" &&
    greenLog(
        `<<${repo.name}>> dependency has been installed and completed`
      );
    command === "BUILD" &&
    greenLog(`<<${repo.name}>> has been packaged and built`);
    console.log("stdout", stdout);
  };
};

/* 执行shell脚本 */
const execProcess = async (command, repo) => {
  console.log("🚀 ~ execProcess ~ command:", command);
  const bashCommand = packManager[global.DEFAULT_PACKAGE_MANAGER][command](repo);
  console.log("🚀 ~ execProcess ~ bashCommand:", bashCommand);
  await exec(bashCommand, (error, stdout, stderr) => {
    if (error) {
      console.error(`Failed to run 'yarn install' in ${repo.url}:`, error);
      return;
    }
    // console.log(`Yarn install output for ${repo.url}: ${stdout}`);
    execLog(command, repo)(stdout);
    if (stderr) console.error(`Yarn install errors for ${repo.url}: ${stderr}`);
  });
};


module.exports = {
  execProcess,
};
