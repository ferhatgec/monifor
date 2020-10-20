#!/bin/sh

mkdir $HOME/.local/share/monifor

cp scripts/*.fls $HOME/.local/share/monifor/

cp scripts/*.sh $HOME/.local/share/monifor/

sudo valac --pkg gtk+-3.0 --pkg posix Monifor.vala -o /bin/monifor

monifor
