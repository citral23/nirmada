#!/bin/bash
set -euxo pipefail

curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
curl -Lo /etc/yum.repos.d/terra.repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
curl -Lo /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
curl -Lo /etc/yum.repos.d/_copr\:copr.fedorainfracloud.org\:avengemedia\:danklinux.repo https://copr.fedorainfracloud.org/coprs/avengemedia/danklinux/repo/fedora-44/avengemedia-danklinux-fedora-44.repo

dnf5 -y install --setopt=install_weak_deps=False \
    sddm \
    pipewire \
    pipewire-alsa \
    pipewire-pulseaudio \
    pulseaudio-utils \
    wireplumber \
    alsa-lib \
    alsa-ucm \
    alsa-utils \
    qcom-firmware \
    atheros-firmware \
    NetworkManager \
    NetworkManager-wifi \
    iwd \
    wpa_supplicant \
    bluez \
    dbus-broker \
    python3-gobject \
    python3-websocket-client \
    polkit \
    upower \
    sudo \
    rsync \
    curl \
    jq \
    htop \
    lsof \
    unzip \
    evtest \
    dbus-x11 \
    xdg-user-dirs \
    xdg-terminal-exec \
    btrfs-progs \
    parted \
    gdisk \
    binutils \
    blas \
    bzip2-libs \
    lapack \
    xz \
    dracut \
    dracut-config-generic \
    plymouth \
    plymouth-system-theme \
    plymouth-theme-spinner \
    zenity \
    seatd

# CachyOS Proton's ARM64 GStreamer asks for Arch's libbz2 soname.
ln -sf libbz2.so.1 /usr/lib64/libbz2.so.1.0

# Some AppImages link zlib's unversioned development soname.
ln -sf libz.so.1 /usr/lib64/libz.so

# pressure-vessel needs en_US.UTF-8; the base image ships only minimal-langpack (C.utf8).
dnf5 -y install --setopt=install_weak_deps=False glibc-langpack-en

dnf5 -y install --setopt=install_weak_deps=False \
    google-noto-sans-cjk-vf-fonts \
    google-noto-sans-thai-vf-fonts \
    google-noto-sans-arabic-vf-fonts \
    google-noto-sans-hebrew-vf-fonts \
    google-noto-sans-devanagari-vf-fonts \
    google-noto-color-emoji-fonts

dnf5 -y install --setopt=install_weak_deps=False \
    heroic-games-launcher \
    brave-origin \
    brightnessctl \
    btop \
    cargo \
    cava \
    chezmoi \
    cliphist \
    ddcutil \
    dialog \
    distrobox \
    eog \
    fastfetch \
    fira-code-fonts \
    freerdp \
    git \
    gnome-calculator \
    gnome-clocks \
    gparted \
    ImageMagick \
    iptables-legacy \
    jetbrainsmono-nerd-fonts \
    kitty \
    mediawriter \
    mpv \
    nautilus \
    nautilus-extensions \
    papers-nautilus \
    niri \
    noctalia-shell \
    papers \
    python3-pip \
    qt6ct \
    screen \
    tailscale \
    telnet \
    vim \
    vulkan-tools \
    waydroid \
    wlsunset \
    yazi \
    zed

dnf5 -y install --setopt=install_weak_deps=False \
    --repofrompath 'copr-ublue-os-packages,https://download.copr.fedorainfracloud.org/results/ublue-os/packages/fedora-$releasever-$basearch/' \
    --setopt=copr-ublue-os-packages.gpgcheck=0 \
    --setopt=copr-ublue-os-packages.repo_gpgcheck=0 \
    flatpak \
    bazaar

mkdir -p /etc/flatpak/remotes.d
curl --retry 3 -fsSL -o /etc/flatpak/remotes.d/flathub.flatpakrepo \
    https://dl.flathub.org/repo/flathub.flatpakrepo
