#!/usr/bin/env bash
set -e
pushd ~/leafNix
clear
git pull
clear
set +o pipefail
nh os switch ~/leafNix || exit 0
set -o pipefail
echo  -e "\n\033[34mNixOS rebuild completed\033[0m"
echo -ne "\rExit in 1" && sleep 1
echo -ne "\033[?1049l"
clear
popd
clear