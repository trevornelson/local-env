######################################
# Messing with files
######################################
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
#   extract:  Extract most know archives with one command
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

# mcd: Make directory and cd into it
mcd () { mkdir -p "$1" && cd "$1"; }

######################################
# Shell and system navigation
######################################
alias refresh='source ~/.zshrc'
alias ll='ls -FGlAhp'
alias ..='cd ../'
alias ...='cd ../../'
alias f='open -a Finder ./'
alias qfind="find . -name"
alias less='less -FSRXc'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
cd () { builtin cd "$@"; ls; }

######################################
# Why is this running shittily
######################################
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias flushDNS='dscacheutil -flushcache'
#   findPid: Find process id
findPid () {
  lsof -t -c "$@";
}
# my_ps: List processes owned by current user
my_ps() {
  ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command;
}
# killport: Find and kill process running on a given port
killport () {
  lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
}

######################################
# Git
######################################

# fuckYoBranches: Deletes local branches that have been merged into the base branch
fuckYoBranches () {
  git branch --merged | egrep -v "(^\*|master|main)" | xargs git branch -d
}

# gitSlug: Returns a sluggified version of your git username.
gitSlug () {
  typeset -l output
  output=${"$(git config user.name)"// /}
  echo $output
}

# gojira: Create a branch for a given Jira ticket number.
gojira () {
  echo $1
  if [ -z "$1" ]; then
    echo "You need to specify a Jira issue code, ya dingus!"
  else
    git checkout -b "$(gitSlug)/$1"
  fi
}

######################################
# Misc
######################################
alias editHosts='sudo edit /etc/hosts'
alias httpErr='tail /var/log/httpd/error_log'
alias be='bundle exec'
pullrailsmain () {
  git pull origin main && bundle install && bin/rake db:migrate && RAILS_ENV=test bin/rake db:migrate
}
rubocopmodified () {
  git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop
}
# mans: Manual search
mans () {
  man $1 | grep -iC2 --color=always $2 | less
}
#   httpHeaders: Grabs headers from web page
httpHeaders () {
  /usr/bin/curl -I -L $@;
}
# httpDebug: Download a web page and show info on what took time
httpDebug () {
  /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n";
}
