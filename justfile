set windows-shell := ['powershell.exe', '-command']

odinc := 'odin'
bin := if os() == "windows" {
    'bin/heatmetal.exe'
} else {"bin/heatmetal"}

build:
    {{odinc}} build . -out:{{bin}} -o:minimal -define:ALWAYS_SAVE_SETTINGS=true

build_release:
    {{odinc}} build . -out:{{bin}} -o:speed

run:
    {{bin}}

alias r := run
alias b := build
alias br := build_release