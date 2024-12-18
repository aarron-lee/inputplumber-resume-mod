#!/usr/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root. don't use sudo" >&2
    exit 1
fi

echo "starting install of suspend-resume mods"

sudo cp ../suspend-mods.sh /usr/local/bin/suspend-mods
sudo cp ../resume-mods.sh /usr/local/bin/resume-mods

sudo chmod +x /usr/local/bin/suspend-mods
sudo chmod +x /usr/local/bin/resume-mods

json_file="/usr/share/ublue-os/image-info.json"

if [[ -f "$json_file" ]]; then
    image_name=$(grep -oP '"image-name"\s*:\s*"\K[^"]+' "$json_file")

    if [[ "$image_name" =~ bazzite ]]; then
        echo "bazzite detected, handling for SE Linux"

        sudo chcon -u system_u -r object_r --type=bin_t /usr/local/bin/suspend-mods
        sudo chcon -u system_u -r object_r --type=bin_t /usr/local/bin/resume-mods
    else
        echo "The image-name is not 'bazzite', it is '$image_name'."
    fi
else
    echo "Bazzite not detected, continuing installation"
fi

# disable services if they already exist
sudo systemctl disable --now resume-mods.service
sudo systemctl disable --now suspend-mods.service

sudo cp ../resume-mods.service /etc/systemd/system
sudo cp ../suspend-mods.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable resume-mods.service
sudo systemctl enable suspend-mods.service

echo "installation complete!"
