#!/bin/sh

mkdir $HOME/.local/monifor/

cp scripts/*.sh $HOME/.local/monifor

sudo valac --pkg gtk+-3.0 Monifor.vala -o /bin/monifor

monifor
