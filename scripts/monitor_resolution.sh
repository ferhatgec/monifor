#!/bin/sh

xrandr | grep \* | awk '{print $1}'
