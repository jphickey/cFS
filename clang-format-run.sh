#!/bin/bash

set -x

wdc="${PWD##$HOME/code/cfecfs/github/}"
my_uid=$(id -u)
my_gid=$(id -g)
[ "x$wdc" == "x$PWD" ] && /bin/false

docker run --rm --name test -u $my_uid:$my_gid --mount type=bind,source="$HOME/code/cfecfs/github",target=/src -w "/src/$wdc" clang-format clang-format-11 -style=file -i $*
