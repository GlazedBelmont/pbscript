#!/bin/bash


printf 'This script needs to be run as superuser (root on most unix systems)\n'

sudo su - root << EOF
echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm;

dnf update --refresh -y;

dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin sound-and-video;
dnf group upgrade -y --with-optional Multimedia;
dnf install -y lame\* --exclude=lame-devel intel-media-driver ffmpeg-libs libva libva-utils git;

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; flatpak update

EOF
printf 'Installation finished, please reboot your system\n'
