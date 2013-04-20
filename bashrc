#######################################
### Bash Completion

# Source bash completions from homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Source git's completions from the system installation
if [ -f /usr/share/git-core/git-completion.bash ]; then
	. /usr/share/git-core/git-completion.bash
fi

# Source brew's completions for itself?
if [ -f $(brew --prefix)/etc/bash_completion.d/brew_bash_completion.sh ]; then
	. $(brew --prefix)/etc/bash_completion.d/brew_bash_completion.sh
fi


########################################
### Shell prompt
# TODO: Don't have these in a non-login shell

# if CWD is in a Git repo, show current branch

if [ -f /usr/share/git-core/git-prompt.sh ]; then
	. /usr/share/git-core/git-prompt.sh
	if [ "\$(type -t __git_ps1)" ]; then
		BRANCH="\$(__git_ps1 '%s ')"
	fi
fi

prompt_command () {
 	# set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;`pwdtail`\a'
    export PS1="\[${TITLEBAR}\]${BRANCH}\$ "
}

PROMPT_COMMAND=prompt_command

pwdtail () { #returns the last 2 fields of the working directory
	pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}


########################################
### Terminal Colors

# export CLICOLOR=true
# export CLICOLOR_FORCE=true
alias ls='ls -1G'
# alias less='less -R'


#######################################
### Text Editing

# Set editor to sublime text when logged in locally
if [ -z "$SSH_TTY" ] ; then
	export EDITOR='subl -w'
fi
alias edit=$EDITOR


#######################################
### Git

alias status='git status'
alias push='git push'
alias pull='git pull; git submodule update --recursive'
alias stash='git stash'
alias log='git log'

# workaround for git-log breaking on long commit msgs
export LESS="erX"

#######################################
### Python

export SYSPATH=$PATH
export MYPATH=/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin # virtualenv, pip, 2.7.4
export PATH=$MYPATH

export VIRTUALENV_DISTRIBUTE=true
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

syspip(){
	PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
