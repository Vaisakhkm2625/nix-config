# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
# You can import other home-manager modules here
    imports = [
# If you want to use home-manager modules from other flakes (such as nix-colors):
# inputs.nix-colors.homeManagerModule

# You can also split up your configuration and import pieces of it here:
# ./nvim.nix
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
# Workaround for https://github.com/nix-community/home-manager/issues/2942
            allowUnfreePredicate = (_: true);
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
        ncdu
        htop
        btop
        zip
        unzip
        ranger
        ripdrag
        zoxide
        starship
        exa
        wl-clipboard
        playerctl
        poppler_utils #pdfunite, other pdf utils
        stow
        ydotool
        mlocate
        fd
        mpv
        xdotool
        xclip
        lazygit
        jq
        bc
        pipx
        grim
        jrnl # journl software(for my diaries)


        appimage-run

#gui apps
        teams
        libreoffice
        gh
        kitty
        easyeffects
        brave
        obs-studio
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

#hyperland config
        networkmanagerapplet
        waybar
        rofi-wayland
        
        libnotify
        dunst
        swww
        brightnessctl
        wlogout
        swaylock

#theme
#        dconf
        materia-kde-theme
        libsForQt5.qtstyleplugin-kvantum


#temp
        logisim-evolution

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

    gtk.theme.package = pkgs.materia-theme;
    gtk.theme.name = "Materia-dark-compact";

    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=MateriaDark
            '';

    home.sessionVariables = {
        QT_STYLE_OVERRIDE = "kvantum";
        GTK_USE_PORTAL = 1;
    };

#/---themeing

# Enable home-manager and git
    programs.home-manager.enable = true;
    programs.git = {
        enable = true;
        userName  = "Vaisakh K M";
        userEmail = "vaisakhkm2625@gmail.com";
    };
    programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
            nodejs
            python311Packages.pip
            gcc

            ripgrep
        ];
    };

# Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
                                    }
