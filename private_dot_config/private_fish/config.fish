abbr cd.. ".."
abbr cd... "../.."
abbr cd.... "../../.."
abbr cd..... "../../../.."
abbr l "ls -la"
abbr gitb "git checkout --track origin/master -b"
fish_vi_key_bindings

status --is-interactive; and rbenv init - | source


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

starship init fish | source
