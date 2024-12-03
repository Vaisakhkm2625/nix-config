
{ pkgs,... }:
{


dconf = {
  settings = {
    "org/gnome/desktop/interface" = {
	#gtk-theme = "Adwaita-dark";
	#color-scheme = "prefer-dark";

	gtk-theme = "rose-pine-gtk-theme";
	color-scheme = "prefer-dark";

    };
  };
};

gtk = {
  enable = true;
  theme = {
    #name = "Adwaita-dark";
    #package = pkgs.gnome.gnome-themes-extra;
    name = "rose-pine-gtk-theme";
    package = pkgs.rose-pine-gtk-theme;
  };
};

#qt = {
#  enable = true;
#  #platformTheme.name = "Adwaita-dark";
#  style = {
#    name = "Adwaita-dark";
#    package = pkgs.adwaita-qt;
#  };
#};
}
