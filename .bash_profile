alias nano="nano --smooth --constantshow --autoindent --softwrap"

##############################################################################
# 01. EXPORTS                                                                #
##############################################################################

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Make vim the default editor
export EDITOR="vim"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

##############################################################################
# 02. ALIASES                                                                #
##############################################################################

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias dot="cd /home/danielbartsch/projects/settings;"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Shortcuts
alias bashconf="code ~/projects/settings/.bash_profile"
alias loadbash="source ~/projects/settings/.bash_profile"

alias gmd="git merge develop"
alias gmu="gd;pb;gmd"
alias gitconf="code ~/.gitconfig"
alias insights-db="psql --cluster 10/main -Upmedia adverity-db"

alias new="clear; git flow feature start"
alias pull="git pull"
alias push="git push"

# switch projects/repos
function workon {
  if [ "$@" = "datatap" ]; then
    cd ~/projects/datatap/;
    virtualenv .;
    source bin/activate;
    pip install -r requirements.txt -r requirements-dev.txt;
    python datatap/manage.py migrate;
    npm run backend;
  fi
}

# Git branch bash completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
    
  # Add git completion to aliases
  # __git_complete g __git_main
  __git_complete to _git_checkout
  # __git_complete gm __git_merge
  # __git_complete gp _git_pull
fi

alias ll='ls -al'
alias mv='mv -i'
alias cp='cp -i -p'
alias ls='ls -abp --color=auto'
alias grep='grep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

##############################################################################
# 04. PROMPT COLORS                                                          #
##############################################################################

# copied from https://github.com/mathiasbynens/dotfiles/

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		# echo -e "${1}${branchName}${2}${s}";
		echo -e "${1}${branchName}${2}";
	else
		return;
	fi;
}

#if tput setaf 1 &> /dev/null; then
#	tput sgr0; # reset colors
#	bold=$(tput bold);
#	reset=$(tput sgr0);
#	# Solarized colors, taken from http://git.io/solarized-colors.
#	black=$(tput setaf 0);
#	blue=$(tput setaf 33);
#	cyan=$(tput setaf 37);
#	green=$(tput setaf 64);
#	orange=$(tput setaf 166);
#	purple=$(tput setaf 125);
#	red=$(tput setaf 124);
#	violet=$(tput setaf 61);
#	white=$(tput setaf 15);
#	yellow=$(tput setaf 136);
#else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
#fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
#PS1+="\t "; # time
#PS1+="\[${white}\] at ";
#PS1+="\[${hostStyle}\]\h"; # host
#PS1+="\[${white}\] in ";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${white}\]\[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
#PS1+="\n";
PS1+="\[${white}\]\[${reset}\]❯ "; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

##############################################################################
# 05. BASH                                                                   #
##############################################################################

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

##############################################################################
# 06. EXTRA                                                                  #
##############################################################################

[ -f ~/.extra ] && source ~/.extra

if [[ -a ~/.localrc ]]; then
    source ~/.localrc
fi

[[ -s "./.gitShortcuts" ]] &&  source "./.gitShortcuts"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] &&  source "$HOME/.sdkman/bin/sdkman-init.sh"

# Puts date in front of history of commands
HISTTIMEFORMAT="%d.%m.%Y %T "
