#!/usr/bin/env bash
set -e
pushd ~/leafNix
clear
sudo deadnix -e
clear
if git diff --quiet ; then
    echo "\nNo changes detected, exiting."
    popd
    exit 0
fi
clear
git diff -U0 '*.nix'
set +o pipefail
nh os switch ~/leafNix || exit 0
set -o pipefail
echo  -e "\n\033[34mNixOS rebuild completed\033[0m"
echo -ne "\rExit in 1" && sleep 1
echo -ne "\033[?1049l"
clear
alejandra *
clear
current=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) \(.date) \(.nixosVersion) \(.kernelVersion)"')
git commit -am "$current"
git push origin master
popd
clear