# git-pull-action
远程仓库更新

初衷是拉取最新代码的同时保证某些“配置文件”不被替换。

## 使用案例
> 从Github拉取最新代码到Gitee，并自动部署Pages

- 需Github和Gitee都有相同的仓库，且启动Pages
  - Gitee可通过导入Github仓库进行首次同步。
- 在Github仓库Setting设置Secrets
  - GITEE_RSA_PRIVATE_KEY: Gitee密钥
  - GITEE_PASSWORD：Gitee登录密码

- 在仓库下创建：.github/workflows/config.yml

~~~yml
name: Config

on: page_build

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Sync to Gitee
        uses: liuconglook/git-pull-action@master
        env:
          # 注意在 Settings->Secrets 配置 GITEE_RSA_PRIVATE_KEY
          SSH_PRIVATE_KEY: ${{ secrets.GITEE_RSA_PRIVATE_KEY }}
        with:
          # 注意替换为你的 GitHub 源仓库地址
          source-repo: git@github.com:liuconglook/notes.git
          # 注意替换为你的 Gitee 目标仓库地址
          destination-repo: git@gitee.com:cleve/notes.git
          # 你需要忽略更新的文件列表，多个文件用逗号隔开
          ignore-files: index.html

      - name: Build Gitee Pages
        uses: yanglbme/gitee-pages-action@main
        with:
          # 注意替换为你的 Gitee 用户名
          gitee-username: cleve
          # 注意在 Settings->Secrets 配置 GITEE_PASSWORD
          gitee-password: ${{ secrets.GITEE_PASSWORD }}
          # 注意替换为你的 Gitee 仓库，仓库名严格区分大小写，请准确填写，否则会出错
          gitee-repo: notes
          # 要部署的分支，默认是 master，若是其他分支，则需要指定（指定的分支必须存在）
          branch: master
~~~

