# Nixos config

[nix-starter-config](https://github.com/Misterio77/nix-starter-config)

```
sudo nixos-rebuild switch --flake .#nixos
```
```
home-manager switch --flake .#username@hostname
```


if home-manager not there...
```
nix shell nixpkgs#home-manager
```
----

## dirty installtions


```zsh
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

### devenv
```
nix profile install --accept-flake-config tarball+https://install.devenv.sh/latest

```
### easy effects presets

- https://github.com/JackHack96/EasyEffects-Presets

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"
```


## ydotool issue

added user in input group

- really bad
```
sudo chgrp uinput /dev/uinput
sudo chmod g+rwx /dev/uinput
```
# work_notes
