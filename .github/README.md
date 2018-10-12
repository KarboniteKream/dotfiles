# dotfiles

This setup is based on [this blog post by Atlassian](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Instructions

```bash
function dotfiles() {
  git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME $@
}

git clone --bare https://github.com/KarboniteKream/dotfiles.git $HOME/.git-dotfiles
dotfiles checkout
dotfiles submodule init
dotfiles submodule update
dotfiles config --local status.showUntrackedFiles no
```