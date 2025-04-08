{ pkgs, ... }:
{





  gtk = {
    enable = true;
    #theme.package = pkgs.solarc-gtk-theme;
    #theme.name = "SolArc-Dark";
    
    #theme.package = pkgs.nordic;
    #theme.name = "Nordic";

    theme.package = pkgs.juno-theme;
    theme.name = "Juno-ocean";

    #cursorTheme.package = pkgs.bibata-cursors;
    #cursorTheme.name = "Bibata-Modern-Ice";


  };
}
