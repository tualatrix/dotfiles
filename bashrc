parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' | cut -d \  -f 2
}

PS1='`a=$?;if [ $a -ne 0 ]; then echo -n -e "\[\e[01;32;41m\]{$a}"; fi`\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W`b=$(parse_git_branch); if [ x"$b" != "x" ]; then echo -n -e "\[\e[33;40m\](branch:$b)\[\033[01;32m\]\[\e[00m\]"; fi`\[\033[01;34m\] $ \[\e[00m\]'

#DO NOT Need function
PS1='\[\e[01;32m\][\u@\[\e[01;33m\]\h \[\e[01;34m\]\W] `[[ -d .git ]] && echo -n -e "\[\e[01;33m\](branch:$(git branch | sed -e "/^ /d" -e "s/* \(.*\)/\1/"))\[\e[01;34m\] "`\$ \[\e[00m\]'

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=force'
    alias dir='dir --color=force'
    alias vdir='vdir --color=force'

    alias grep='grep --color=force'
    alias fgrep='fgrep --color=force'
    alias egrep='egrep --color=force'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
