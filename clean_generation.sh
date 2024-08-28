sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Delete all generations from 0 to 174
for i in {243..271}; do
  sudo nix-env --delete-generations $i --profile /nix/var/nix/profiles/system
done

# Run garbage collection to clean up
sudo nix-collect-garbage -d 
