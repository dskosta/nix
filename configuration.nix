# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  #vosk-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/kaldi {};
  #dc-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_sub-pkg/default.nix { inherit vosk-pkg;};
  #dcConfig = import /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/default.nix { inherit config pkgs lib; };
  #voskModule = (import /home/kd/github/discreet-communicator-nix-pkg/flake2.nix).nixosModules.vosk;

  
  #dc-utils-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_utils-pkg/default.nix { };
  #icm20948-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/icm20948/default.nix { hatch-fancy-pypi-readme = pkgs.python3Packages.hatch-fancy-pypi-readme;
  #    hatchling = pkgs.python3Packages.hatchling;
  #    smbus2 = pkgs.python3Packages.smbus2;
  #    mock = pkgs.python3Packages.mock;
  #    pytestCheckHook = pkgs.python3Packages.pytestCheckHook;};
  #dc-pkg = import /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_sub-pkg/default.nix { };
  #dc-nats-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_nats-pkg/default.nix { inherit icm20948-pkg dc-utils-pkg;};
  #dc-statistic-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/discreet_communicator_statistic-pkg/default.nix { inherit icm20948-pkg dc-utils-pkg;};
  #netloc_listener_python-pkg = pkgs.callPackage /home/kd/github/discreet-communicator-nix-pkg/packages/vosk/netloc_listener_python-pkg/default.nix {};
  myOverlay = self: super: {
    nrfutil = super.nrfutil.overrideAttrs (oldAttrs: rec {
      doCheck = false;
      doInstallCheck = false; 
    });
  };
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set the number of old boot entries to keep (e.g., 2)
  boot.loader.grub.configurationLimit = 2;

  # Automatically delete old system profiles (optional)
  system.autoUpgrade = {
    enable = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #services.dnsmasq = {
  #enable = true;
  #  servers = [ "8.8.8.8" "8.8.4.4" ];
  #  extraConfig = ''
  #    interface=enp5s0
  #    
  #    dhcp-range=192.168.1.10,192.168.1.254,24h
  #  '';
    #bind-interfaces
    #dhcp-range = [ "192.168.0.2,192.168.0.254" ];
    #extraConfig = ''
    #conf-file=/etc/dnsmasq.conf
  #'';
  #};
  #services.dnsmasq.settings.server = ["8.8.8.8" "8.8.4.4" ];




   #networking.nat.enable = true;
  #networking.nat.internalInterfaces = [ "enp5s0" ];
  #networking.nat.externalInterface = "tun0";
  #networking.nat.externalInterface = "wlp3s0";

  # Set your time zone.
  time.timeZone = "Asia/Dubai";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
	General = {
		Experimental = true;
	};
  };
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #};

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--ipv6 --fixed-cidr-v6 fd00::/80";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kd = {
    isNormalUser = true;
    description = "kd";
    extraGroups = [ "networkmanager" "wheel" "screen" "dialout" "docker" "input" ];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kd";

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.segger-jlink.acceptLicense = true;
  
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];  
  nixpkgs.overlays = [ myOverlay ];
  nix.settings.trusted-users = [ "root" ];#[ "root" "kd" ];
  nixpkgs.config.permittedInsecurePackages = [
                "segger-jlink-qt4-794l"
                "tightvnc-1.3.10"
              ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  google-chrome
  jetbrains.pycharm-community-bin
  gitkraken
  teams-for-linux
  git
  qemu_full
  proot
  wget
  uuu
  bash
  vscode
  screen
  tightvnc
  turbovnc
  #realvnc-vnc-viewer
  telegram-desktop
  pkgs.kdePackages.qttools
  mc
  qbittorrent-qt5
  slack
  openssl
  #nrf5-sdk
  nrfutil
  #nrfconnect
  #nrf-command-line-tools
  virtualbox
  gobject-introspection
  gst_all_1.gstreamer
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-ugly
  gst_all_1.gst-libav
  qt6.full
  socat
  inetutils
  wireshark
  rpiboot
  docker
  docker-compose
  bmon
  ethtool
  gcc-arm-embedded-9
  usbutils
  gnumake
  gpsd
  dnsmasq
  cups
  libtool
  srecord
  cmake
  kdePackages.isoimagewriter
  python3Packages.virtualenv
  python311Packages.gst-python
  (python3.withPackages (ps: with ps; [
        setuptools
        pip
        wheel
        pygobject3
        pyudev
        numpy
        gst-python
        netifaces
        certifi
contourpy
cycler
filelock
fonttools
kiwisolver
matplotlib
networkx
numpy
packaging
pandas
pillow
pyarrow
pyparsing
pyproj
pyserial
python-dateutil
pytz
six
tzdata
pyside6
geographiclib
geopy
    ]))
    binutils

  #dc-pkg 
   #dc-utils-pkg 
   #dc-nats-pkg
   #dc-statistic-pkg   
   #netloc_listener_python-pkg
  ];
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 20000 ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  #networking.firewall = {
  #    enable = true;
  #    allowedTCPPorts = [];
  #    allowedUDPPorts = [];
  #    extraCommands = ''
  #    iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -j MASQUERADE
  #    iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
  #    '';
  #};

services.avahi = {
  enable = true;
  nssmdns = true;
  openFirewall = true;
};
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
