set windows-shell := ['powershell.exe', '-command']

odinc := 'odin'
bin := if os() == "windows" {
    'bin/heatmetal.exe'
} else {"bin/heatmetal"}
del := if os() == "windows" {"del"} else {"rm"}

delete_settings:
    {{del}} settings.*


build:
    {{odinc}} build . -out:{{bin}} -o:minimal -define:DEBUG=true

build_release:
    {{odinc}} build . -out:{{bin}} -o:speed

run:
    {{bin}}

alias ds := delete_settings
alias r := run
alias b := build
alias br := build_release