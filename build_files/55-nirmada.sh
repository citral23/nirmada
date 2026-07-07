#!/bin/bash
set -euxo pipefail

update-alternatives --set iptables /usr/sbin/iptables-legacy
systemctl enable tailscaled

LOCAL_BIN="/var/home/armada/.local/bin"
mkdir -p "$LOCAL_BIN"

curl -fLo "$LOCAL_BIN/lisgd" \
  "https://github.com/citral23/lisgd/releases/download/v1/lisgd"
curl -fLo "$LOCAL_BIN/wvkbd-mobintl" \
  "https://github.com/citral23/wvkbd/releases/download/v1/wvkbd-mobintl"

chown -R armada: "$LOCAL_BIN"

chmod +x "$LOCAL_BIN/lisgd" "$LOCAL_BIN/wvkbd-mobintl"

file "$LOCAL_BIN/lisgd"
file "$LOCAL_BIN/wvkbd-mobintl"

LOCAL_CONF="/var/home/armada/.config"
mkdir -p "$LOCAL_CONF"

cp -r niri_config/niri niri_config/noctalia "$LOCAL_CONF"

chown -R armada: "$LOCAL_CONF"
