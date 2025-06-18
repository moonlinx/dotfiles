#!/bin/bash

ls /Applications/ /Applications/Utilities/ /System/Applications/ /System/Applications/Utilities/ |
  grep '\.app$' |
  sed 's/\.app$//g' |
  choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92" |
  xargs -I {} open -a "{}.app"
