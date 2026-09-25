# Run 'git' without performing optional operations that require locks.
function __git_no_lock() {
  GIT_OPTIONAL_LOCKS="0" command git "$@"
}

# Output the repository status for the prompt.
function __git_prompt_info() {
  local -a info
  info=("${(@f)$(__git_no_lock rev-parse --git-dir --abbrev-ref HEAD 2>/dev/null)}")
  # Detect repositories without commits.
  local unborn="$(( $? != 0 ))"

  # Early return if outside of a Git repository.
  if [[ -z "$info[1]" ]]; then
    return 0
  fi

  local ref="$info[2]"
  if [[ "$unborn" == "1" ]]; then
    # Find the pending branch name.
    if ! ref="$(__git_no_lock symbolic-ref --short HEAD 2>/dev/null)"; then
      return 0
    fi
  elif [[ "$ref" == "HEAD" ]]; then
    # Find what tag or commit the detached HEAD is pointing to.
    if ! ref="$(__git_no_lock describe --tags --exact-match HEAD 2>/dev/null)"; then
      if ! ref="$(__git_no_lock rev-parse --short HEAD 2>/dev/null)"; then
        return 0
      fi
    fi
  fi

  # Check for dirty status, ignoring untracked files.
  local dirty=""
  if [[ "$unborn" == "1" ]]; then
    if ! __git_no_lock diff --cached --quiet 2>/dev/null; then
      dirty=" %F{yellow}~%f"
    fi
  elif ! __git_no_lock diff-index --quiet --ignore-submodules=dirty HEAD -- 2>/dev/null; then
    dirty=" %F{yellow}~%f"
  fi

  # Sanitize '%' in refs to prevent prompt injection.
  echo -n "%F{red}${ref//\%/%%}%f${dirty}"
}

# Output the name of the current branch.
function __git_current_branch() {
  local ref

  if ! ref="$(__git_no_lock symbolic-ref --short HEAD 2>/dev/null)"; then
    # Handle detached HEAD and similar cases.
    ref="$(__git_no_lock rev-parse --short HEAD 2>/dev/null)"
  fi

  if [[ -n "$ref" ]]; then
    echo "$ref"
  fi
}

# Output the name of the main branch.
function __git_main_branch() {
  # Early return if outside of a Git repository.
  if ! __git_no_lock rev-parse --git-dir &>/dev/null; then
    return
  fi

  local ref remote

  # Try the most common branch names.
  for ref in refs/{heads,remotes/{origin,upstream}}/{master,main,trunk}; do
    if __git_no_lock show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done

  # Try to get the main branch from remote HEAD symbolic refs.
  for remote in origin upstream; do
    ref="$(__git_no_lock rev-parse --abbrev-ref "$remote/HEAD" 2>/dev/null)"

    if [[ "$ref" == "$remote"/* ]]; then
      echo "${ref#"$remote/"}"
      return 0
    fi
  done

  # If no main branch was found, fall back to master and return error.
  echo "master"
  return 1
}

alias ga="git add"
alias gapa="git add --patch"
alias gb="git branch"
alias gc!="git commit --amend"
alias gcl="git clone --recurse-submodules"
alias gcm='git checkout $(__git_main_branch)'
alias gcmsg="git commit --message"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gds="git diff --staged"
alias gfa="git fetch --all --tags --prune --jobs=10"
alias gl="git pull"
alias glo="git log --oneline"
alias glog="git log --oneline --branches --graph"
alias glop="git log --patch"
alias gmum='git merge upstream/$(__git_main_branch)'
alias gp="git push"
alias gpsup='git push --set-upstream origin $(__git_current_branch)'
alias gr="git remote"
alias grb="git rebase --interactive"
alias grbm='git rebase --interactive $(__git_main_branch)'
alias grh="git reset"
alias grhc="git reset --soft HEAD~1"
alias grset="git remote set-url"
# Jump to the repository root.
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias grv="git remote --verbose"
alias gsm="git submodule"
alias gst="git status"
alias gsta="git stash push"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gstu="git stash push --include-untracked"
alias gwt="git worktree"

# Add the 'upstream' remote, assuming this is a fork.
function garu() {
  local repository="${$(git remote get-url origin):t}"
  git remote add upstream "git@github.com:$1/$repository" || return
  git remote set-url upstream --push "NO-PUSH"
}

# Checkout a GitHub pull request.
function gpr() {
  git checkout "$(__git_main_branch)" || return
  git fetch upstream "pull/$1/head:PR-$1" || return
  git checkout "PR-$1"
}
