# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    # You can also split up your configuration and import pieces of it here:
    # ./users.nix



    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./laptop.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # FIXME: Add the rest of your current configuration
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;

# https://www.reddit.com/r/NixOS/comments/16ibzb4/nixos_polish_powerline_plymouth_boot_animation_etc/

#boot.plymouth.theme = "bgrt";

#-
boot.initrd.verbose = false;

#-
boot.consoleLogLevel = 0;

#-
boot.kernelParams = [ "quiet" "udev.log_level=0" ];

#https://github.com/NixOS/nixpkgs/pull/215693
#boot.plymouth = {
#    enable = true;
#    #theme = "rings";
#    theme = "circuit";
#
#    themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["circuit"];})];
#  };
#
environment.variables.GTK_USE_PORTAL = "1";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-bc0b5124-bf9c-44d1-b416-c04788852387".device = "/dev/disk/by-uuid/bc0b5124-bf9c-44d1-b416-c04788852387";
  boot.initrd.luks.devices."luks-bc0b5124-bf9c-44d1-b416-c04788852387".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.



  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


#virtualbox
#virtualisation.virtualbox.host.enable = true;
   #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.x11 = true;

# enable v4l2loopback 
boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
boot.kernelModules = [
  "v4l2loopback"
];


#podman
 virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };



  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.flatpak.enable = true;

#  services.xremap = {
#    withHypr = true;
#    userName = "vaisakh";
#
#    };

  ## Enable the X11 windowing system.
  services.xserver.enable = true;

  ## Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;



  services.xserver.windowManager.qtile.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.startx.enable = true;
    services.xserver.libinput.enable = true;

#  services.greetd = {
#      enable = true;
#      settings = {
#          default_session = {
#              command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --time --cmd Hyprland";
#              user = "greeter";
#          };
#      };
#  };
#

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;


#xremap
  hardware.uinput.enable = true;
  users.groups.uinput.members = ["vaisakh"];
  users.groups.input.members = ["vaisakh"];


#bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


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
  users.users.vaisakh = {
    isNormalUser = true;
    description = "vaisakh";
    extraGroups = [ "networkmanager" "wheel" "input"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tailscale
    swaylock-effects
    at
    xfce.thunar
    xfce.thunar-volman
    libsForQt5.kdeconnect-kde
    polkit_gnome
    libsForQt5.qt5.qtgraphicaleffects

    #mlocate
    wpgtk


  ];


  environment.noXlibs = false;

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;

  programs.dconf.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
          thunar-volman
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities

      services.tumbler.enable = true; # Thumbnail support for images


security.polkit.enable = true;


services.gnome.gnome-keyring.enable = true;

#xdg.portal.extraportals = [
#    pkgs.xdg-desktop-portal-gtk
#];
#
#systemd = {
#    user.services.polkit-gnome-authentication-agent-1 = {
#        description = "polkit-gnome-authentication-agent-1";
#        wantedby = [ "graphical-session.target" ];
#        wants = [ "graphical-session.target" ];
#        after = [ "graphical-session.target" ];
#        serviceconfig = {
#            type = "simple";
#            execstart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
#            restart = "on-failure";
#            restartsec = 1;
#            timeoutstopsec = 10;
#        };
#    };
#};

systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};

  #services.gnome3.gnome-keyring.enable = true;
  #security.pam.services.lightdm.enableGnomeKeyring = true;
  #ssh.startAgent = true;
  programs.seahorse.enable = true;

#legacyPackages.x86_64-linux.polkit_gnome

  services.tailscale.enable = true;

  services.atd.enable = true;


  services.locate.enable = true;
  services.locate.locate = pkgs.mlocate;


  security.pam.services.swaylock = {
      text = ''
          auth include login
          '';
  };



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

  services.openssh= {
      enable = true;
      settings = {
          PasswordAuthentication = true;
      };
# I'll disable this once I can connect.
  };

#networking
networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 8096 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
