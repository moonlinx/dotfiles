#!/bin/bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case "$SOURCE" in
'com.apple.keylayout.US' | 'com.apple.keylayout.ABC')
    ICON=🇺🇸
    ;;
'com.apple.keylayout.PinyinKeyboard')
    ICON=🇨🇳
    ;;
*)
    echo "InputSource: $SOURCE not recognized. Add it in plugins/input.sh first."
    ICON="Unknown"
    ;;
esac

sketchybar --set $NAME icon=$ICON
