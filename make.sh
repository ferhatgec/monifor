#!/bin/sh

valac --pkg gtk+-3.0 --pkg posix Monifor.vala -o monifor

./monifor

