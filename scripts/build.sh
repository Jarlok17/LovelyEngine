#!/bin/zsh

rm *.love
zip -9 -r lovely.love . -x "*.git*" "*.love"
