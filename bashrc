#######################################
### Bash Completion

# Source bash completions from homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Source git's completions from the system installation
if [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
	. /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
fi

# Source brew's completions for itself?
if [ -f $(brew --prefix)/etc/bash_completion.d/brew_bash_completion.sh ]; then
	. $(brew --prefix)/etc/bash_completion.d/brew_bash_completion.sh
fi


########################################
### Shell prompt
# TODO: Don't have these in a non-login shell

# if CWD is in a Git repo, show current branch

if [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh ]; then
	. /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
	if [ "\$(type -t __git_ps1)" ]; then
		BRANCH="\$(__git_ps1 '%s ')"
	fi
fi

prompt_command () {
 	# set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;`pwdtail`\a'
    local VENVNAME="`basename $VIRTUAL_ENV 2>/dev/null`"
    export PS1="\[${TITLEBAR}\]${BRANCH}${VENVNAME}\$ "
}

PROMPT_COMMAND=prompt_command

pwdtail () { #returns the last 2 fields of the working directory
	pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}


########################################
### Terminal Colors

# export CLICOLOR=true
# export CLICOLOR_FORCE=true
alias ll='ls -alG'
# alias less='less -R'


#######################################
### Text Editing

# Set editor to sublime text when logged in locally
# if [ -z "$SSH_TTY" ] ; then
# 	export EDITOR='subl -w'
# fi
# alias edit=$EDITOR


#######################################
### Git

alias status='git status'
alias push='git push --recurse-submodules=check'
alias pull='git pull; git submodule update --recursive --merge'
alias stash='git stash'
alias log='git log'

# workaround for git-log breaking on long commit msgs
export LESS="erX"

#######################################
### Python

export PATH=/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin # virtualenv, pip, 2.7.4

export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# virtualenvwrapper - ALWAYS SET AFTER PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development/Python
source /usr/local/bin/virtualenvwrapper.sh

syspip(){
	PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

#######################################
### Java

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home
export GROOVY_HOME=/usr/local/opt/groovy/libexec

#######################################
### Go

GOROOT=/usr/local/go
export GOPATH=~/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

