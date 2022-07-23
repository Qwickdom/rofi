#!/usr/bin/env bash

# GitHub
user_git="Qwickdom"
URL="https://github.com/$user_git/"

dir="$HOME/.config/bspwm/rofi/themes"
dirg="$HOME/$user_git"
rofi_command="rofi -theme $dir/git.rasi"

# Get all the repositories for the user with curl and GitHub API and filter only
# the repository name from the output with sed substitution
my_repositories() {
  curl -s "https://api.github.com/users/$user_git/repos?per_page=1000" | grep -o 'git@[^"]*' |\
    sed "s/git@github.com:$user_git\///g"
}

# Rofi dmenu
rofi_dmenu() {
  rofi -theme "$dir"/clone.rasi -dmenu -p "Select a repository: "
}

create_dir() {
  if [ ! -d $dirg ]; then
    mkdir $dirg
  fi
}

# Clone a repository into the current directory
clone_repository() {
  local repository=$1
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone "$URL$repository" "$dirg/$repository"
  fi
}

main() {
  repository=$(my_repositories | rofi_dmenu )
  create_dir
  clone_repository "$repository"
}

# Browser
app="chromium --incognito"

# Links
git=""
search=""
clone=""

# Variable passed to rofi
options="$git\n$search\n$clone"

chosen="$(echo -e "$options" | $rofi_command -p "GitHub | Search | Clone" -dmenu -selected-row 1)"
case $chosen in
  $git)
    $app $URL &
    ;;
  $search)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
      if [[ "$ans" == "" ]]; then
        rofi -theme $dir/askpass.rasi -e "   Nothing to search"
      else
        $app 'https://www.github.com/search?q='${ans// /+} &
      fi
    ;;
  $clone)
    main
    ;;
esac
