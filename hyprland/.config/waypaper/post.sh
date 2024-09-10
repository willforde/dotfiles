#!/bin/sh

# Vars
wallpaper_dir="$HOME/.cache/waypaper"
current_wallpaper="$wallpaper_dir/current"
square_wallpaper="${current_wallpaper}-square.png"
blurred_wallpaper="${current_wallpaper}-blurred.png"
blurred_small_wallpaper="${current_wallpaper}-blurred-small.png"


# Ensure wallpaper directory exists
mkdir -p $wallpaper_dir

# Remove old link and replace with new link
rm -f $current_wallpaper
ln -s $1 $current_wallpaper

# Create square wallpaper
#echo ":: Generate cached square wallpaper"
#magick $1 -gravity Center -extent 1:1 $square_wallpaper

# Create blurred wallpaper
echo ":: Generate cached blurred wallpaper"
#magick $1 -scale 10% -blur 0x3 -resize 1000% $blurred_wallpaper
magick $1 -scale 10% -blur 0x3 $blurred_small_wallpaper
