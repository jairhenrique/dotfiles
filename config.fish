#Virtualfish - python virtualenv
set -g VIRTUALFISH_COMPAT_ALIASES
. ~/dev/dotfiles/virtualfish/virtual.fish
. ~/dev/dotfiles/virtualfish/auto_activation.fish
. ~/dev/dotfiles/virtualfish/global_requirements.fish

# PATH
set PATH /usr/local/bin $HOME/bin
set PATH $PATH /usr/local/sbin /usr/bin /bin /usr/sbin /sbin /usr/X11/bin 
set PATH $PATH /usr/local/share/npm/bin #npm

set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

set -xg JAVA_HOME (/usr/libexec/java_home)

function rbenv_shell
  set -l vers $argv[1]

  switch "$vers"
    case '--complete'
      echo '--unset'
      echo 'system'
      exec rbenv-versions --bare
      return
    case '--unset'
      set -e RBENV_VERSION
    case ''
      if [ -z "$RBENV_VERSION" ]
        echo "rbenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$RBENV_VERSION"
      end
    case '*'
      rbenv prefix "$vers" > /dev/null
      set -g -x RBENV_VERSION "$vers"
  end
end

function rbenv
  set -l command $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$command"
    case shell
      rbenv_shell $args
    case '*'
      command rbenv $command $args
  end
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'

# Git colors
set __fish_git_prompt_color_branch red
set __fish_git_prompt_color_dirtystate yellow
set __fish_git_prompt_color_untrackedfiles cyan
 
# Status Chars
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_untrackedfiles ' ✚ '
set __fish_git_prompt_char_dirtystate ' ☂ '
set __fish_git_prompt_char_stagedstate ' → '
set __fish_git_prompt_char_stashstate ' ↩ '
set __fish_git_prompt_char_upstream_ahead ' ↑ '
set __fish_git_prompt_char_upstream_behind ' ↓ '


function my_prompt_pwd -d 'Print the current working directory'
  echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
  set_color $fish_color_cwd
  echo -n (my_prompt_pwd)
  set_color normal

  if set -q VIRTUAL_ENV
    set_color yellow
    echo -n  " ("(basename "$VIRTUAL_ENV")")"
    set_color normal
  end

  echo (__fish_git_prompt)
  set_color normal
  echo ' ⟩ '
end

function fish_right_prompt -d "Write out the right prompt"
  set -l last_status $status
  
  set_color green
  
  if test $last_status -ne 0
    set_color red
  end
  
  date "+%H:%M:%S"
  set color normal
end
