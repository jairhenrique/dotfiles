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
