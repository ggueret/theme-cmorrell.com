# ggueret fish theme

![screenshot](https://raw.githubusercontent.com/ggueret/theme-ggueret/master/screenshot.png)

This theme is forked from [cmorrell](https://github.com/oh-my-fish/theme-cmorrell.com), thanks to him for his excellent work !

Color scheme used is the [Tomorrow Night Theme](https://github.com/chriskempson/tomorrow-theme) using the [Ubuntu Mono](https://design.ubuntu.com/font/) font type.

## Install

ggueret-theme is not yet submitted to appear as an official omf package.

Thereby, an additional step is required before enabling the theme :

```sh
git clone https://github.com/ggueret/theme-ggueret.git $OMF_PATH/themes/ggueret
```

Then, enable the theme :
```sh
omf theme ggueret
```

Do not pay attention to the error, it is normal since we cloned the package just before.

## Customize

The initial goal is to be able to override anything displayed on line :

```sh
set -x FISH_THEME_DEFAULT_STATUS ""
set -x FISH_THEME_SEPARATOR "\$"
set -x FISH_PROMPT_HOSTNAME (hostname -s)
set -x FISH_PROMPT_WHOAMI (whoami)
```

# Chris Morrell's Fish Theme

This is a theme I designed for myself but have given to a few friends and decided to publish for others' enjoyment.

![Chris Morrell's Fish Theme](https://cloud.githubusercontent.com/assets/21592/4770904/8a58e026-5b89-11e4-927c-42a387b41df0.gif)

## Features

- Minimal base prompt
- Shows compact git status w/ the number of changed files & current branch
- Gives a visual indication when you're logged in via SSH, or logged in as anyone
    but the default user (set the `$default_user` list variable to define your default user)
- Shows indicator if previous command failed
- Shows a bright red "!" if you're logged in as root

(Note: _This theme is designed for a light-on-dark theme like [Solarized](http://ethanschoonover.com/solarized) but should work in a dark-on-light terminal with a few terminal color tweaks_)
