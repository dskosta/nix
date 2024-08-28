{ pkgs ? import <nixpkgs> {} }:
let 
  #vosk-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/vosk_python {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.gobject-introspection
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
    pkgs.python3
    pkgs.python3Packages.pygobject3
    #vosk-pkg
    pkgs.alsa-utils
    #pkgs.python3Packages.pyudev
    #pkgs.python3Packages.numpy
    pkgs.python3Packages.gst-python
    pkgs.python3Packages.netifaces
    pkgs.python3Packages.certifi
    pkgs.python3Packages.evdev
    pkgs.python3Packages.nats-py
pkgs.python3Packages.contourpy
pkgs.python3Packages.cycler
pkgs.python3Packages.filelock
pkgs.python3Packages.fonttools
pkgs.python3Packages.kiwisolver
pkgs.python3Packages.matplotlib
pkgs.python3Packages.networkx
pkgs.python3Packages.numpy
pkgs.python3Packages.packaging
pkgs.python3Packages.pandas
pkgs.python3Packages.pillow
pkgs.python3Packages.pyarrow
pkgs.python3Packages.pyparsing
pkgs.python3Packages.pyproj
pkgs.python3Packages.pyserial
pkgs.python3Packages.python-dateutil
pkgs.python3Packages.pytz
pkgs.python3Packages.six
pkgs.python3Packages.tzdata
pkgs.python3Packages.pyside6
pkgs.python3Packages.geographiclib
pkgs.python3Packages.geopy
pkgs.python3Packages.paramiko
pkgs.python3Packages.sounddevice

  ];
} 

#{ pkgs ? import <nixpkgs> {} }:
#pkgs.mkShell {
#  buildInputs = [
#    pkgs.pkg-config
#    pkgs.cairo
#    pkgs.gobject-introspection
#    pkgs.python3Packages.pygobject3
#    pkgs.python3Packages.pycairo
#  ];
#}