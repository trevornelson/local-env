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
  git branch --merged | egrep -v "(^\*|master|main|release)" | xargs git branch -d
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

changedFiles() {
  git diff --name-only HEAD | xargs
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
fixeslintmodified () {
  echo $1
  if [ -z "$1" ]; then
    echo "You need to specify a base branch to compare with, ya dingus!"
  else
    yarn eslint --fix $(git diff --name-only --diff-filter=ACMRTUXB $1 | grep -E "(.js$|.ts$|.tsx$)")
  fi 
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

trevgrok () {
  echo $1
  if [ -z "$1" ]; then
    echo "You need to specify a localhost, ya dingus!"
  else
    ngrok http --domain=bursting-early-eel.ngrok-free.app $1
  fi 
}

trevconsole () {
  if [ -z "$1" ]; then
    echo "Connecting to retirable-app"
    heroku run bin/rails console --app retirable-app
  else
    heroku run bin/rails console --app $1
  fi
}

fuckyocache () {
  sudo
  yarn cache clean
  docker system prune -a
  brew cleanup -s
  rm -rf ~/Library/Caches/Homebrew/*
  rm -rf ~/Library/Caches/*
  rm -rf ~/Library/Developer/Xcode/DerivedData
  rm -rf ~/Library/Caches/com.apple.dt.Xcode
  rm -rf ~/Library/Developer/CoreSimulator
}

ls_size () {
  du -h -d 1 | sort -hr | awk '{print $1, $2}'
}

imfeelinglucky () {
  DB_NAME=prod_copy bin/rails runner \
  "puts Rails.application.routes.url_helpers.advisor_login_url(household_id: Facts::Household.wealth_management_clients.sample.id, host: 'localhost', port: 3000, protocol: 'http')" \
  | xargs open
}

start_retirable () {
  tmux new-session -s retirable-dev -d
  tmux split-window -h -t retirable-dev:0.0
  tmux split-window -v -t retirable-dev:0.1

  tmux send-keys -t retirable-dev:0.0 'eval "$(mise activate bash)" && bundle exec rails server' C-m
  tmux send-keys -t retirable-dev:0.1 'eval "$(mise activate bash)" && yarn build --watch' C-m
  tmux send-keys -t retirable-dev:0.2 'eval "$(mise activate bash)" && bundle exec rails c' C-m
    
  tmux new-window -t retirable-dev:1 -n "ngrok"
  tmux send-keys -t retirable-dev:ngrok 'trevgrok 3000' C-m

  tmux attach -t retirable-dev:0.0
}

stop_retirable () {
  tmux send-keys -t retirable-dev:0.0 C-c
  tmux send-keys -t retirable-dev:0.1 C-c
  tmux send-keys -t retirable-dev:0.2 C-c

  sleep 2

  tmux kill-session -t retirable-dev
}

