#!/bin/bash

source "/Users/fox/.config/sketchybar/icon_map.sh"

# General Icons
LOADING=􀖇
APPLE=􀣺
PREFERENCES=􀺽
ACTIVITY=􀒓
LOCK=
BELL=􀋚
BELL_DOT=􀝗
MUSIC=􀑪

# Yabai Icons
YABAI_STACK=􀏭
YABAI_FULLSCREEN_ZOOM=􀂓
YABAI_PARENT_ZOOM=􀥃
YABAI_FLOAT=􀢌
YABAI_GRID=􀧍
YABAI_SPLIT_VERTICAL=􀘜
YABAI_SPLIT_HORIZONTAL=􀧋

# Battery Icons
BATTERY_100=􀛨
BATTERY_75=􀺸
BATTERY_50=􀺶
BATTERY_25=􀛩
BATTERY_0=􀛪
BATTERY_CHARGING=􀢋

# Volume Icons
VOLUME_100=􀊩
VOLUME_66=􀊧
VOLUME_33=􀊥
VOLUME_10=􀊡
VOLUME_0=􀊣

export ICON_CMD=󰘳
export ICON_COG=󰒓   # system settings, system information, tinkertool
export ICON_CHART=󱕍 # activity monitor, btop
export ICON_LOCK=󰌾
export ICON_APP=󰣆 # fallback app

export ICON_PACKAGE=󰏓 # brew
__icon_map "Code"
export ICON_DEV="${icon_result}"
export ICON_VSCODIUM= # nvim, xcode, vscode
export ICON_FILE=󰉋     # ranger, finder
__icon_map "Finder"
export ICON_FINDER="${icon_result}"
export ICON_GIT=󰊢            # lazygit
export ICON_LIST=󱃔           # taskwarrior, taskwarrior-tui, reminders, onenote
export ICON_SCREENSAVOR=󱄄    # unimatrix, pipe.sh
export ICON_WEATHER=󰖕        # weather
export ICON_MAIL=󰇮           # mail, outlook
export ICON_CALC=󰪚           # calculator, numi
export ICON_MAP=󰆋            # maps, find my
export ICON_MICROPHONE=󰍬     # voice memos
export ICON_CHAT=󰭻           # messages, slack, teams, telegram
export ICON_VIDEOCHAT=󰍫      # facetime, zoom, webex
export ICON_NOTE=󱞎           # notes, textedit, stickies, word, bat
export ICON_CAMERA=󰄀         # photo booth
export ICON_WEB=󰇧            # safari, beam, duckduckgo, arc, edge, chrome, firefox
export ICON_HOMEAUTOMATION=󱉑 # home
__icon_map "Music"
export ICON_MUSIC="${icon_result}"
# export ICON_MUSIC=􀫀 # music, spotify
export ICON_PODCAST=󰦔       # podcasts
export ICON_PLAY=󱉺          # tv, quicktime, vlc
export ICON_BOOK=󰂿          # books
export ICON_BOOKINFO=󱁯      # font book, dictionary
export ICON_PASSKEY=󰷡       # 1password
export ICON_DOWNLOAD=󱑢      # progressive downloader, transmission
export ICON_CAST=󱒃          # airflow
export ICON_TABLE=󰓫         # excel
export ICON_PRESENT=󰈩       # powerpoint
export ICON_CLOUD=󰅧         # onedrive
export ICON_PEN=󰏬           # curve
export ICON_REMOTEDESKTOP=󰢹 # vmware, utm
export ICON_CLOCK=󰥔         # clock, timewarrior, tty-clock
export ICON_CALENDAR=󰃭      # calendar
export ICON_WIFI=􀙇
export ICON_WIFI_OFF=􀙈
export ICON_VPN=󰦝 # vpn, nordvpn
export ICONS_VOLUME=(󰸈 󰕿 󰖀 󰕾)
export ICONS_BATTERY=(󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
export ICONS_BATTERY_CHARGING=(󰢟 󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
export ICON_SWAP=󰁯
export ICON_RAM=󰓅
export ICON_DISK=󰋊 # disk utility
export ICON_CPU=󰘚
export ICON_CONTROLCENTER=􀜊

# My apps
__icon_map "Discord"
export ICON_DISCORD="${icon_result}" # Discord
__icon_map "Slack"
export ICON_SLACK="${icon_result}" # Slack
__icon_map "Postman"
export ICON_POSTMAN="${icon_result}" # Postman
__icon_map "OBS"
export ICON_OBS="${icon_result}" # OBS
__icon_map "Obsidian"
export ICON_OBSIDIAN="${icon_result}"
__icon_map "WhatsApp"
export ICON_WHATSAPP="${icon_result}"
__icon_map "Terminal"
export ICON_TERM="${icon_result}" # Terminal
export ICON_PHOTOSHOP=
export ICON_AFTEREFFECTS=󱁑
export ICON_PHOTOS=
__icon_map "Figma"
export ICON_FIGMA="${icon_result}"
export ICON_KICAD=
export ICON_THINGS=
export ICON_DOWNLOAD=􁾮 # Jdownloader2
export ICON_ICON=􀼱     # SF Symbols
export ICON_STEAM=󰓓    # Steam
__icon_map "Arc"
export ICON_ARC="${icon_result}"
export ICON_GLM=󰓃
export ICON_SAFARI=󰀹
__icon_map "Google Chrome"
export ICON_CHROME="${icon_result}"
__icon_map "Docker Desktop"
export ICON_DOCKER_DESKTOP="${icon_result}"
__icon_map "App Store"
export ICON_APP_STORE="${icon_result}"
__icon_map "Zen Browser"
export ICON_ZEN_BROWSER="${icon_result}"
export ICON_PREVIEW=󰋲
