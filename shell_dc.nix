{ pkgs ? import <nixpkgs> {} }:
let 
icm20948-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/icm20948/default.nix { hatch-fancy-pypi-readme = pkgs.python3Packages.hatch-fancy-pypi-readme;
      hatchling = pkgs.python3Packages.hatchling;
      smbus2 = pkgs.python3Packages.smbus2;
      mock = pkgs.python3Packages.mock;
      pytestCheckHook = pkgs.python3Packages.pytestCheckHook;};
  dc-pkg = import /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_sub-pkg/default.nix { inherit (pkgs) lib python3Packages alsa-utils gobject-introspection glib gst_all_1 installShellFiles makeWrapper wrapGAppsHook;
  icm20948-pkg = icm20948-pkg;};
in
pkgs.mkShell {
  buildInputs = [
    dc-pkg
    
  ];
} 