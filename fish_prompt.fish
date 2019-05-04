set -g pad " "

## Function to show a segment
function prompt_segment -d "Function to show a segment"
  # Get colors
  set -l bg $argv[1]
  set -l fg $argv[2]

  # Set 'em
  set_color -b $bg
  set_color $fg

  # Print text
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

function prompt_whitespace -d "Function to show a whitespace"
  set_color -b normal
  set_color normal
  echo -n -s " "
end

function prompt_carriage_return -d "Function to show a carriage return"
  echo -e -n "\r"
end

## Function to show current status
function show_status -d "Function to show the current status"
  if [ $RETVAL -ne 0 ]
    prompt_segment red white " $RETVAL "; prompt_whitespace
    set pad ""
    return
  end
  if [ -n "$SSH_CLIENT" ]
    prompt_segment blue white " SSH: "; prompt_whitespace
    set pad ""
    return
  end
  if [ -n "$FISH_THEME_DEFAULT_STATUS" ]
    prompt_segment normal yellow " $FISH_THEME_DEFAULT_STATUS "; prompt_whitespace
  end
end

function show_virtualenv -d "Show active python virtual environments"
  if set -q VIRTUAL_ENV
    set -l venvname (basename "$VIRTUAL_ENV")
    if [ $venvname = ".virtualenv" ]
      set venvname (basename "$PWD")
    end
    prompt_segment normal normal "($venvname) "
  end
end

## Show user if not in default users
function show_user -d "Show user"
  if not contains $USER $default_user; or test -n "$SSH_CLIENT"
    if test -z $FISH_PROMPT_HOSTNAME
      set -x FISH_PROMPT_HOSTNAME (hostname -s)
    end
    if test -z $FISH_PROMPT_WHOAMI
      set -x FISH_PROMPT_WHOAMI (whoami)
    end
    prompt_segment normal yellow $FISH_PROMPT_WHOAMI

    # Skip @ bit if hostname == username
    if [ "$USER" != "$HOST" ]
      prompt_segment normal normal "@"
      prompt_segment normal green "$FISH_PROMPT_HOSTNAME "
      set pad ""
    end
  end
end

function _set_venv_project --on-variable VIRTUAL_ENV
    if test -e $VIRTUAL_ENV/.project
        set -g VIRTUAL_ENV_PROJECT (cat $VIRTUAL_ENV/.project)
    else
      set -l venvname (basename "$VIRTUAL_ENV")
      if [ $venvname = ".virtualenv" ]
        set -g VIRTUAL_ENV_PROJECT $PWD
      end
    end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd
  if [ (string match -r '^'"$VIRTUAL_ENV_PROJECT" $PWD) ]
    set pwd (string replace -r '^'"$VIRTUAL_ENV_PROJECT"'($|/)' '≫$1' $PWD)
  else
    set pwd (prompt_pwd)
  end
  prompt_segment normal blue "$pad$pwd "
end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
  if test -z $FISH_THEME_SEPARATOR
    set -x FISH_THEME_SEPARATOR "\$"
  end

  set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
    prompt_segment red white " $FISH_THEME_SEPARATOR "
    set_color normal
    echo -n -s " "
  else
    prompt_segment normal white "$FISH_THEME_SEPARATOR "
    end

  set_color normal
end

## SHOW PROMPT
function fish_prompt
  set -g RETVAL $status
  prompt_carriage_return
  show_status
  show_virtualenv
  show_user
  show_pwd
  show_prompt
end
