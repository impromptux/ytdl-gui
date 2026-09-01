#!/bin/bash
CURRENT_DIR=$(pwd)
rm rpmbuild/ 2> /dev/null
mkdir rpmbuild
mkdir rpmbuild/BUILD rpmbuild/BUILDROOT rpmbuild/RPMS rpmbuild/SOURCES rpmbuild/SPECS rpmbuild/SRPMS
version=$(git describe --tags||(git fetch --tags > /dev/null &&git describe --tags --always))
version="${version:1}" #remove the "v"

mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/bin
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/

cp ../../build/youtubedl-gui rpmbuild/SOURCES/youtubedl-gui-$version/bin/ 2>/dev/null || cp $1 rpmbuild/SOURCES/youtubedl-gui-$version/bin/youtubedl-gui 2>/dev/null || cp ../$1 rpmbuild/SOURCES/youtubedl-gui-$version/bin/youtubedl-gui 2>/dev/null || echo please run \"bash ./resources/debian/deb.sh /path/to/the/executable \"

mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/applications
cp ../../resources/youtubedl-gui.desktop rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/applications/page.codeberg.impromptux.ytdl-gui.desktop
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/16x16/apps/
cp ../../icons/16x16.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/16x16/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/32x32/apps/
cp ../../icons/32x32.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/32x32/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/48x48/apps/
cp ../../icons/48x48.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/48x48/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/64x64/apps/
cp ../../icons/64x64.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/64x64/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/128x128/apps/
cp ../../icons/128x128.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/128x128/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/256x256/apps/
cp ../../icons/256x256.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/256x256/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/512x512/apps/
cp ../../icons/512x512.png rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/512x512/apps/page.codeberg.impromptux.ytdl-gui.png
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/scalable/apps/
cp ../../icons/ytdl_logo.svg rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/icons/hicolor/scalable/apps/page.codeberg.impromptux.ytdl-gui.svg
mkdir -p rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/ytdl-gui/locales
cp ../../locales/ytdl-gui_*.qm rpmbuild/SOURCES/youtubedl-gui-$version/usr/share/ytdl-gui/locales

cd rpmbuild/SOURCES/
# tar -czvf bin/youtubedl-gui usr/
tar -czvf ytdl-gui.tar.gz youtubedl-gui-$version/bin/ youtubedl-gui-$version/usr/ > /dev/null
cd $CURRENT_DIR

################################ SPECS/youtubedl-gui.spec ########################################
echo 'Name:           youtubedl-gui
Version:        '$version'
Release:        2
Summary:        A simple-to-use graphical interface for downloading videos and audio
BuildArch:      x86_64

License:        GPL
Source0:        ytdl-gui.tar.gz

Requires:       ffmpeg, yt-dlp, libnotify, qt6-qtbase-gui, qt6-qtbase
Packager:       impromptux@mailo.com
Vendor:         Impromptux
URL:            https://codeberg.org/impromptux/ytdl-gui

%description
Downloads videos and audio from a variety of sites. Allows control of format, resolution, audio and video codecs, etc.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
cp bin/youtubedl-gui $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}
cp -r usr/share/icons/ $RPM_BUILD_ROOT/%{_datadir}
cp -r usr/share/ytdl-gui/ $RPM_BUILD_ROOT/%{_datadir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/applications/
cp  usr/share/applications/page.codeberg.impromptux.ytdl-gui.desktop $RPM_BUILD_ROOT/%{_datadir}/applications/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/youtubedl-gui
%{_datadir}/icons/hicolor/16x16/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/32x32/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/48x48/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/64x64/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/128x128/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/256x256/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/512x512/apps/page.codeberg.impromptux.ytdl-gui.png
%{_datadir}/icons/hicolor/scalable/apps/page.codeberg.impromptux.ytdl-gui.svg
%{_datadir}/ytdl-gui/locales/ytdl-gui_*.qm
%{_datadir}/applications/page.codeberg.impromptux.ytdl-gui.desktop

%changelog
* Sun Aug  30 2026 Antoine "Impromptux" <impromptux@mailo.com> - 1
- See https://codeberg.org/impromptux/ytdl-gui/releases

%global debug_package %{nil}

%post
ln --symbolic /usr/bin/youtubedl-gui /usr/bin/ytdl-gui || exit 0
' > rpmbuild/SPECS/youtubedl-gui.spec
##################################################################################################
HOME=$(pwd) rpmbuild -bb rpmbuild/SPECS/youtubedl-gui.spec
cp rpmbuild/RPMS/x86_64/* ytdl-gui.rpm
rm rpmbuild/ -r
