
function _rmsshhostkey {
    sed -i "${1}d" ~/.ssh/known_hosts
}
alias rmhostkey=_rmsshhostkey

function calc() {
    awk "BEGIN{print (${@})}"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lathr'
alias la='ls -A'
alias l='ls -CF'

# mkdir and cd into it
function _mkcd {
    if [ -z ${1+x} ]
    then
        echo "usage: ${0} new_dir_name"
        return
    fi
    mkdir -p "${1}" && cd "${1}"
}
alias mkcd=_mkcd

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


function _verup {
    repo=$(git remote -v | awk '{print $2; exit}')
    curr=$(git -c 'versionsort.suffix=-' ls-remote --exit-code --sort='version:refname' --tags ${repo} '*.*.*' | tail -n1 | cut -d'/' -f3)
    next=$(eval $(echo ${curr} | sed -n -r 's/([0-9]+\.[0-9]+)\.([0-9]+)/echo "\1.$((\2+1))"/p'))
    sed -i '' -r "s/VERSION=[0-9]+\.[0-9]+\.[0-9]+/VERSION=${next}/" Makefile
}
alias versionup=_verup

