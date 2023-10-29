#!/bin/bash -ue

apt update
apt install --yes direnv cargo cmake git zplug vim
cargo install exa

echo dein_installer動かす

