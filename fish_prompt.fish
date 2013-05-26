# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch white
 
# Status Chars
set __fish_git_prompt_char_dirtystate '±'
set __fish_git_prompt_char_cleanstate ''
set __fish_git_prompt_char_stagedstate ' →'
set __fish_git_prompt_char_stashstate ' ↩'
set __fish_git_prompt_char_upstream_ahead ' ↑'
set __fish_git_prompt_char_upstream_behind ' ↓'

function my_prompt_pwd --description 'Print the current working directory'
  echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
  set_color $fish_color_cwd
  printf '%s' (my_prompt_pwd)
  set_color normal
 
  printf '%s ' (__fish_git_prompt)
  set_color normal
end

function fish_right_prompt -d "Write out the right prompt"
  set -l last_status $status
  
  set_color green
  
  if test $last_status -ne 0
    set_color red
  end
  
  date "+%d-%m-%y %H:%M"
  set color normal
end
