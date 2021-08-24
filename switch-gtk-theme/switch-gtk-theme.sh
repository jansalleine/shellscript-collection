#!/bin/sh
CURTHEME=`gsettings get org.gnome.desktop.interface gtk-theme`

if [ "$CURTHEME" = "'Adwaita-light'" ]
then
    gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
else
    gsettings set org.gnome.desktop.interface gtk-theme Adwaita-light
fi
