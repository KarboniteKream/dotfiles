# dotfiles

This setup is based on [this blog post by Atlassian](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Instructions

```bash
function dotfiles() {
  git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME $@
}

git clone --bare git@github.com:KarboniteKream/dotfiles.git $HOME/.git-dotfiles
dotfiles checkout
dotfiles submodule update --init
dotfiles config status.showUntrackedFiles no

ln -s ~/.zsh/plugins/base16-shell/scripts/base16-atelier-forest.sh .base16_theme
```

## Submodules

The submodules can be updated with `dotfiles submodule update --remote`.
