git add .
git commit -m "before flake updating on $(date)"
nix flake update
sudo nixos-rebuild switch --flake .#nixos
git add .
git commit -m "after flake updating on $(date)"
