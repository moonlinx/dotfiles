# Utility Bar - Rosé Pine Moon
<div align=center>
<img width="1470" height="40" alt="Screenshot 2025-08-21 at 12 39 13" src="https://github.com/user-attachments/assets/230c1063-cb96-4686-9745-270335e650e5" />
<img width="1470" height="40" alt="Screenshot 2025-08-21 at 12 39 39" src="https://github.com/user-attachments/assets/c34be030-27f3-4bf4-a7df-d1119208c824" />

</div>


This is a config I made which aggregate functionnality and aesthetics.

See https://github.com/FelixKratz/SketchyBar/discussions/47?sort=new#discussioncomment-14058252

> [!WARNING] 
> Some of the functionnalities of the bar are not working currently in MacOS Tahoe.

## Install :

Install sketchybar

```bash
brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar
```

Install this config with its dependencies

```bash
# brew install yabai # Recommended only if you already have a config
# brew install brew install waydabber/betterdisplay/betterdisplaycli # Recommended if using better display Configure [here](<plugins/display/script.sh>)
# (Also recommended for battery control - when clicking battery icon : https://github.com/mhaeuser/Battery-Toolkit)

brew install media-control macmon imagemagick
brew install --cask font-SF-Pro font-sketchybar-app-font

mkdir -p ~/.config
cd ~/.config/
git clone https://www.github.com/Kcraft059/sketchybar-config sketchybar

sketchybar --reload
```

For yabai users : `yabai -m config external_bar all:36:0`

For Nix-Darwin users see : https://github.com/Kcraft059/Nix-Config/blob/master/home/darwin/sketchybar.nix

> [!NOTE]
> Aerospace isn't supported, if you wanna implement it see : https://github.com/FelixKratz/SketchyBar/discussions/47?sort=new#discussioncomment-14081291

## A little demonstration of the functionalities :

<img width="2940" height="1912" alt="Screenshot 2025-08-09 at 18 49 42" src="https://github.com/user-attachments/assets/23066c77-1b31-4372-a737-8bf450af1d80" />
<img width="2940" height="1912" alt="Screenshot 2025-08-09 at 18 55 12" src="https://github.com/user-attachments/assets/0406413d-4468-4ba7-b55d-1c59e7e52cfb" />


https://github.com/user-attachments/assets/c9db52a4-d7fe-4daa-a904-cd201476556c
