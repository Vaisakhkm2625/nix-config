# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit inputs;
  };
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.xremap-flake.homeManagerModules.default
    #inputs.stylix.homeManagerModules.stylix
        # inputs.catppuccin.homeManagerModules.catppuccin
    #            inputs.yazi-flake
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./screen_copy.nix
    ./theme.nix
    ./systemd/notify-hi.nix
    #./darktheme.nix
  ];



  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      (self: super: {
        mpv = super.mpv.override {
          scripts = [self.mpvScripts.mpris];
        };
      })

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "vaisakh";
    homeDirectory = "/home/vaisakh";
  };

  fonts.fontconfig.enable = true;


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;

  home.packages = with pkgs; [
    # cli terminal apps
    tmux
    fzf
    #tuxmux
    ncdu
    #btop
    zip
    unzip
    #ranger
    yazi
    ripdrag
    zoxide
    starship
    eza
    wl-clipboard
    cliphist
    playerctl
    poppler_utils #pdfunite, other pdf utils
    stow
    findutils
    unstablePkgs.obsidian
    ydotool
    foot
    #mlocate


    fd
    mpv
    #xdotool
    #wlrctl
    #xclip
    lazygit
    jq
    bc
    libqalculate
    pipx
    grim
    #jrnl # journl software(for my diaries)
    #wtype
    rofimoji #emoji seletor
    rofi-bluetooth

    imagemagick
    satty 


    hyprpaper

    pavucontrol
    nix-search-cli
    #pet
    eclipses.eclipse-java
    man-pages # c development man pages
    exiftool

    swayidle
    #nwg-dock-hyprland 

    unstablePkgs.hyprcursor
    #unstablePkgs.wl-kbptr

    qrencode
    timg

    #drawio

    sway-audio-idle-inhibit

    swaynotificationcenter

    pyprland

    appimage-run
    steam-run

    #inxi

    #gui apps
    #teams
    libreoffice
    gh
    #kitty
    easyeffects
    brave
    obs-studio
    gimp
    zathura
    #thunderbird
    #vscode
    shotwell
    #qbittorrent
    losslesscut-bin
    vlc
    imv
    blender
    #qtcreator

    #jellyfin
    mpvpaper
    yt-dlp
    #cava
    (pkgs.nerdfonts.override {fonts = ["Terminus" "FiraCode" "DroidSansMono"];})

    #hyperland config
    networkmanagerapplet
    #waybar
    rofi-wayland
    slurp

    libnotify
    #dunst
    swww
    brightnessctl
    wlogout
    protonvpn-gui
    pywal



#xorg things.. remove
scrot
xclip
#xorg things.. remove

    inputs.xremap-flake.packages.${system}.default
    #inputs.yazi-flake.packages.${system}.default

    #theme
    #        dconf
    materia-kde-theme
    rose-pine-gtk-theme
    #libsForQt5.qtstyleplugin-kvantum
    wpgtk # don't know needed... setting gtk from pywal

    ############ development ##################
    # LSPs
    # typstfmt
    # typst-lsp
    # typst-live
    cmake-language-server
    python311Packages.python-lsp-ruff
    #python311Packages.python-lsp-server
    python311Packages.pylsp-rope
    lua-language-server
    # ruff-lsp
    clang-tools_16
    nodePackages_latest.bash-language-server

    #java-language-server

    #poetry
    # nodePackages_latest.vscode-langservers-extracted
    # nodePackages_latest.typescript-language-server
    # nodePackages_latest."@tailwindcss/language-server"
    # typescript
    # quick-lint-js

    # global installs

    nodePackages_latest.live-server

    #   unstablePkgs.neovim

# uncomment this for rust dev
#     rustc
#     cargo
#   rust-analyzer




    #temp
    #logisim-evolution
    #paperless-ngx

#remote screenshare

#    waypipe
#    xpra
  ];

  #    dconf = {
  #       enable = true;
  #       settings = {
  #           "org/gnome/desktop/interface" = {
  #               color-scheme = "prefer-dark";
  #           };
  #       };
  #   };

  #---themeing

 gtk.enable = true;

 gtk.cursorTheme.package = pkgs.bibata-cursors;
 gtk.cursorTheme.name = "Bibata-Modern-Ice";

 # gtk.theme.package = pkgs.adw-gtk3;
 # gtk.theme.name = "adw-gtk3";

 # qt.enable = true;
 # qt.platformTheme= "gtk";
 # qt.style.name= "adwaita-dark";

 gtk.iconTheme.package = pkgs.papirus-icon-theme;
 gtk.iconTheme.name = "Papirus-Dark";

 #gtk.theme.package = pkgs.materia-theme;
 #gtk.theme.name = "Materia-dark-compact";

 #xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
 #    [General]
 #    theme=MateriaDark
 #        '';

# TODO: define mime types
  #xdg.mimeApps = {
  #  associations.added = {
  #      "application/pdf" = 
  #  };
  #};

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    GTK_USE_PORTAL = 1;
  };

  #/---themeing

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Vaisakh K M";
    userEmail = "vaisakhkm2625@gmail.com";
  };

  #programs.rofi=  {
  #    enable = true;
  #    plugins = [
  #        pkgs.rofi-calc
  #    ];

  #};

  programs.htop = {
    enable = true;
    settings.show_cpu_temperature = 1;
  };

  programs.neovim = {
    enable = true;
    # TODO: 2023-12-18
    #package = unstablePkgs.neovim;
    #extraConfig = ":luafile ~/.config/nvim/init.lua";
    extraLuaPackages = ps: [ps.magick];

    plugins = [
      pkgs.vimPlugins.flutter-tools-nvim
    ];

    extraPackages = with pkgs; [

      #image preview for foot
      libsixel


      # along with language-server, please add language packages also
      #nodejs
      python311Packages.pip
      gcc
      clang-tools_16
      lua51Packages.luarocks
      lua51Packages.magick
      tectonic


      cmake-language-server
      gopls
      #vimPlugins.markdown-preview-nvim

      jdk
      java-language-server
      jdt-language-server
      #clangd

      eclipses.eclipse-jee

      typstfmt
      typst-lsp

      go
      nodejs_18
      yarn
      ripgrep

      rustc
      cargo
      rust-analyzer
      angular-language-server

    ];
  };

programs.vscode = {
    enable = true;
    userSettings = {
      "window.titlebarstyle" = "custom";
    };
  };


# stylix.image = pkgs.fetchurl {
#     url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
#     sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
#   };
#   stylix.polarity = "dark";
  #stylix.targets.playmouth.enable =false;
#


# home.file = {
#     ".config/Code/User/settings.json".text = ''
#     {
#         "window.titleBarStyle": "custom"
#             // Add other settings here if needed
#     }
#     '';
# };


  #programs.waybar = {
  #    enable = true;
  #    package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"] ;} );
  #};

  #services.gvfs.enable = true; # Mount, trash, and other functionalities

  #services.tumbler.enable = true; # Thumbnail support for images

  #xremap

  services.xremap = {
    #withHypr = true;
    yamlConfig = ''
      keymap:
      - remap:
      CapsLock-i: Up
    '';
  };


  services.kdeconnect = {
      enable = true;
      #package = pkgs.kdePackages.kdeconnect-kde;
      indicator = true;
  };


  programs = {
    direnv = {
      enable = true;
      #enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    #zsh.enable = true; # see note on other shells below
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;
  #home.stateVersion = "24.05";
}
