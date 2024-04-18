const Git = require("simple-git");
const path = require("path");
const repos = [
  {
    url: "<repo1-url>",
    dest: "/path/to/repo1",
    branch: "feature-branch", // 新增分支名称
  },
  {
    url: "<repo2-url>",
    dest: "/path/to/repo2",
    branch: "development",
  },
  // 更多仓库及其分支...
];

// 定义Git操作常量
const OPERATIONS = {
  CLONE: "clone",
  PULL: "pull",
  SWITCH_BRANCH: "switch_branch",
};

// 定义对应的操作函数
const OPERATION_FUNCTIONS = {
  [OPERATIONS.CLONE]: async (repo, gitInstance) =>
    gitInstance.clone(repo.url, repo.dest),
  [OPERATIONS.PULL]: async (repo, gitInstance) => gitInstance.pull(),
  [OPERATIONS.SWITCH_BRANCH]: async (repo, gitInstance) => {
    if ("branch" in repo) {
      return gitInstance.checkout(repo.branch);
    }
    console.warn(
      `Repository ${repo.url} does not contain a branch property, skipping branch switch.`
    );
  },
};


/* 校验本地仓库是否存在 */
const getHasLocalRepos = async (repo, gitInstance) => {
    const gitInstance = Git(repo.dest);
    const status = await gitInstance.revparse(["--show-toplevel"]);
    if (!status.trim()) {
      throw new Error("Repository does not exist locally.");
    }
    return status.trim()
}

async function processRepositories(repos, operation, errorMessageOnFailure, successMessage) {
    try {
      await Promise.all(
        repos.map(async (repo) => {
          const gitInstance = Git(repo.dest);

         const isHasLocalRepos =  await getHasLocalRepos(repo, gitInstance)
            
         /* 如过本地仓库不存在 */
         if (!isHasLocalRepos) {
            // 只能执行clone操作
            operation = OPERATIONS.PULL
         }
          // 克隆或拉取操作
           await OPERATION_FUNCTIONS[operation](repo, gitInstance).catch((err) => {
            console.error(`Operation "${operation}" for repository ${repo.url} failed:`, err);
            throw err;
          });
  
          // 克隆完成后，进入仓库目录并执行 yarn 命令
          if (operation === OPERATIONS.CLONE) {
            const yarnInstallCommand = `cd ${repo.dest} && yarn`;
            await execProcess(yarnInstallCommand)
          }


          // 特殊处理分支切换成功的输出
        if (operation === OPERATIONS.SWITCH_BRANCH && "branch" in repo) {
            console.log(
            `Repository ${repo.url} has been checked out to branch ${repo.branch}.`
            );
        }
        })
      );
  
      console.log(successMessage);
    } catch (err) {
      console.error(errorMessageOnFailure, err);
    }
  }

// 统一切换分支
const switchBranchMessageSuccess =
  "All repositories have been switched to their respective branches.";
const switchBranchMessageFailure =
  "One or more repositories failed during branch switching.";

processRepositories(
  repos,
  OPERATIONS.SWITCH_BRANCH,
  switchBranchMessageFailure,
  switchBranchMessageSuccess
);
