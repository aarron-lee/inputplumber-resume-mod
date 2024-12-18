# Inputplumber Resume Mods

This installs systemd services that runs bash scripts on suspend/resume

After installation, you can find the bash scripts at:

```
/usr/local/bin/suspend-mods
/usr/local/bin/resume-mods
```

# Install instructions

run the following in terminal

```
curl -L https://raw.githubusercontent.com/aarron-lee/inputplumber-resume-mod/main/install.sh | sh
```

# Uninstall instructions

```
sudo systemctl disable --now resume-mods.service
sudo systemctl disable --now suspend-mods.service

sudo rm /usr/local/bin/suspend-mods
sudo rm /usr/local/bin/resume-mods

sudo rm /etc/systemd/system/resume-mods.service
sudo rm /etc/systemd/system/suspend-mods.service
```
