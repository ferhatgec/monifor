#!/bin/sh

xrandr | grep " connected" | cut -f1 -d " "
