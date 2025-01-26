## Reset Macos to other versions

After spending a frustrating amount of time trying to figure this out on macOS Sequoia 15.2 and failing, I finally found the way to move between version. 
Instead of having to use that stupid app store, I can do things this way and make it easy.

## Steps
1. First you want to see if you have the version imbeded somewhere
```bash
softwareupdate --list-full-installers
```
2. Once you find what you are looking for, pull the version:
```bash
softwareupdate --fetch-full-installer --full-installer-version 14.7.2
```
3. Name your USB "MyVolume" and use the following command line command to change it into a bootable usb 
```bash
sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```
