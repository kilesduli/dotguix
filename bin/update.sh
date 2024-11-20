#!/usr/bin/env sh
script_dir="$(dirname "$(realpath "$0")")"
echo "($script_dir)"
sudo -i guix pull --channels=$script_dir/../channels.scm
sudo -i guix describe --format=channels > $script_dir/../channels-lock.scm
