#!/bin/launch-me-with bash ./resources/debian/deb.sh path_to_youtube-dl
mkdir deb 2>/dev/null
cd deb
mkdir DEBIAN 2>/dev/null
version=$(git describe --tags||(git fetch --tags > /dev/null &&git describe --tags --always))
version="${version:1}" #remove the "v"
##################################DEBIAN/control####################################################
echo "Package: youtubedl-gui
Source: youtubedl-gui (3.0-2)
Version: "$version"
Architecture: amd64
Maintainer: Antoine Impromptux <impromptux@mailo.com>
#Installed-Size: 0          # TODO:calculate it
Depends: libc6 (>= 2.34), libgcc-s1 (>= 3.3.1), libqt6core6t64, libqt6gui6, libqt6widgets6, libstdc++6 (>= 13.1), yt-dlp
Recommends: libnotify-bin
Section: web
Priority: optional
Multi-Arch: foreign
Homepage: https://codeberg.org/impromptux/ytdl-gui
Description: A simple-to-use graphical interface for downloading videos and audio
 Downloads videos and audio from a variety of sites. Allows control of format, resolution, audio
 and video codecs, etc." > DEBIAN/control
###################################################################################################
####################################DEBIAN/postinst################################################
echo "#!/bin/bash
ln --symbolic /usr/bin/youtubedl-gui /usr/bin/ytdl-gui || exit 0" > DEBIAN/postinst
###################################################################################################
chmod 0755 DEBIAN/postinst
mkdir -p usr/bin
cp ../build/youtubedl-gui usr/bin 2>/dev/null || cp $1 usr/bin 2>/dev/null || cp ../$1 usr/bin 2>/dev/null ||echo please run \"bash ./resources/debian/deb.sh /path/to/the/executable \"
mkdir -p usr/share/applications
cp ../resources/youtubedl-gui.desktop usr/share/applications/page.codeberg.impromptux.ytdl-gui.desktop
mkdir -p usr/share/doc/youtubedl-gui
###########################usr/share/doc/youtubedl-gui/copyright####################################
echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: youtubedl-gui
Upstream-Contact: Antoine Impromptux <impromptux@mailo.com>
Source: https://codeberg.org/impromptux/ytdl-gui

Files: *
Copyright: 2026 Antoine Impromptux <impromptux@mailo.com>
License: GPL-3+" > usr/share/doc/youtubedl-gui/copyright
###################################################################################################
touch usr/share/doc/youtubedl-gui/changelog.gz      #TODO: generate the changelog instead of doing this
mkdir -p usr/share/icons/hicolor/16x16/apps/
cp ../icons/16x16.png usr/share/icons/hicolor/16x16/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/32x32/apps/
cp ../icons/32x32.png usr/share/icons/hicolor/32x32/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/48x48/apps/
cp ../icons/48x48.png usr/share/icons/hicolor/48x48/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/64x64/apps/
cp ../icons/64x64.png usr/share/icons/hicolor/64x64/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/128x128/apps/
cp ../icons/128x128.png usr/share/icons/hicolor/128x128/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/256x256/apps/
cp ../icons/256x256.png usr/share/icons/hicolor/256x256/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/512x512/apps/
cp ../icons/512x512.png usr/share/icons/hicolor/512x512/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p usr/share/icons/hicolor/scalable/apps/
cp ../icons/ytdl_logo.svg usr/share/icons/hicolor/scalable/apps/page.codeberg.impromptux.ytdl-gui.svg
mkdir -p usr/share/ytdl-gui/locales
cp ../locales/ytdl-gui_*.qm usr/share/ytdl-gui/locales
find . -type f -not -path "./DEBIAN/*" -exec md5sum {} + | sort -k 2 | sed 's/\.\/\(.*\)/\1/' > DEBIAN/md5sums
cd ..
dpkg-deb -b deb ytdl-gui.deb
