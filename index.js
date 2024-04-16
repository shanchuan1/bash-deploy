const { execFile } = require('child_process');

// bash的安装路径 可通过 where bash 命令查看
const bashInstallPath = 'C:\\Program Files\\Git\\usr\\bin\\bash.exe'
const scriptPath  = './bin/clone.sh'

// 使用execFile执行脚本
execFile(bashInstallPath, ['-c', scriptPath],(error, stdout, stderr) => {
  if (error) {
    console.error(`执行脚本发生错误: ${error}`);
    return;
  }
  console.log(`stdout: ${stdout}`);
  console.error(`stderr: ${stderr}`);
});
