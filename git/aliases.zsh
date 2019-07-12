# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gcaa='git commit -a --amend -C HEAD'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'

# Make an AAA ticket branch.
branchaaa() {
    eval "git pull && git checkout -b dgoldsborough/AAA-$1"
}

# Make a DATA ticket branch.
branchdata() {
    eval "git pull && git checkout -b dgoldsborough/DATA-$1"
}

# Commit easily to an AAA ticket branch.
function gitaaa() {
    if [[ "$(git rev-parse --abbrev-ref HEAD)" =~ 'AAA-[0-9]*' ]]; then
        ticket=$MATCH
  	    echo "Writing a commit with ticket ${ticket}"
  	    command="git commit -m \"$ticket $1\""
  	    eval "${command}"
    else
        echo "Not an AAA ticket branch!"
    fi
}

# Commit easily to a DATA ticket branch.
function gitdata() {
    if [[ "$(git rev-parse --abbrev-ref HEAD)" =~ "DATA-[0-9]*" ]]; then
        ticket=$MATCH
  	    echo "Writing a commit with ticket ${ticket}"
  	    command="git commit -m \"$ticket $1\""
  	    eval "${command}"
    else
        echo "Not a DATA ticket branch!"
    fi
}

# Delete local branches
alias gclean='git branch -D `git branch | grep "DATA\|AAA\|PDP" | xargs`'
