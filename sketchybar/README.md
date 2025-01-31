# SketchyBar Config

This repository is my personal configuration for [SketchyBar](https://github.com/FelixKratz/SketchyBar), a macOS plugin to customize the top menu bar. My configuration is largely derived from and built upon [this repository](<https://github.com/FelixKratz/dotfiles>)

![SketchyBar Config Appearance (Lua)](https://github.com/user-attachments/assets/eba2970a-4195-4cc9-9ce1-3dc73f72b8cf)

- This resides here: [branch](https://github.com/moonlinx/dotfiles/commit/55fe15abee8af0d7a5ac5ecd103bdd04a4220a32)

![SketchyBar Config Appearance (Shell)](https://github.com/user-attachments/assets/db4d5e7d-1507-4958-a854-f034c7672a5f)

- This resides here: [branch](https://github.com/moonlinx/dotfiles/commit/493d1bf2aa8ae74a6365fae5ff61165871e57a56)

## Notable Enhancements

In addition to possessing all the features of the aforementioned configuration, this also offers the following improvements:

- **Battery Health** information, displayed when the Battery Widget is clicked.
- Redesigned **Calendar Widget** that takes up less space and opens Calendar when clicked.
- **Clipboard Widget** that displays up to five of your last copied items. Clicking an item re-copies it.
- Support for a **JSON Configuration File** to customize various aspects of the bar.
- Improved **Media Widget**, with superior play/pause functionality.
- **Restart Widget** to refresh SketchyBar; useful for development.
- **RAM Widget** that displays the current RAM utilization, along with a graph.
- **VPN Icon** that displays on the **Wifi Widget**, when a connected to a VPN.
- **Weather Widget** that displays current temperature and conditions, with a pop-up menu displaying semi-hourly forecast for the next two days.

## Installation

1. Install [Homebrew](https://brew.sh/).

2. Install [Luarocks](https://luarocks.org/):

```bash
brew install luarocks
```

3. Install [Luajson](https://github.com/grafi-tt/lunajson):

```bash
sudo luarocks install lunajson
```

4. Run the following script, sourced from [this repository](https://github.com/FelixKratz/dotfiles):

```bash
curl -L https://raw.githubusercontent.com/FelixKratz/dotfiles/master/install_sketchybar.sh | sh
```

5. Run the following command to clone this repository and have it overwrite the SketchyBar configuration:

```bash
git clone https://github.com/moonlinx/dotfiles.git
```

6. Restart SketchyBar:

```bash
brew services restart sketchybar
```
