import os
import platform

# This script is used to update all package managers on the system and then
# ouptut the results to a file

# STEPS #
# 1. Check if the script is run as root
# 2. Check which OS you are running and determine which package managers and
#    path to use
# 3. Run the package managers update and upgrade
# 4. Output the results to a file


# Check if the script is run as root
def is_root():
    if os.getuid() == 0:
        print("You're root")
        return True
    else:
        print("This script must be run as root.")
        return False


# Check which OS you are running and determine which package managers and path to use
def get_os():
    if platform.system() == "Darwin":
        return "macOS"
    elif platform.system() == "Linux":
        return "Linux"
    elif platform.system() == "Windows":
        return "Windows"


# Run the package managers update and upgrade
def update_package_managers():
    os_type = get_os()
    if os_type == "macOS":
        os.system("brew update")
        answer = input("Would you like to upgrade all packages? (y/n): ")
        if answer.lower() == "y":
            os.system("brew upgrade")
        else:
            print("Skipping upgrade")
    elif os_type == "Linux":
        os.system("sudo nala update && sudo nala upgrade")
        os.system("flatpak update && flatpak upgrade")
