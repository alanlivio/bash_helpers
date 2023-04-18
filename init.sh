#!/bin/bash

BH_DIR="$(dirname "${BASH_SOURCE[0]}")"
BH_LIB="$BH_DIR/lib"

#########################
# load os_<name>.bash files
#########################

source "$BH_DIR/os_any.bash"
case $OSTYPE in
msys*)
  source "$BH_DIR/os_win.bash"
  alias gs='gswin64.exe'
  alias winpath='cygpath -m'
  ;;
linux*)
  source "$BH_DIR/os_ubu.bash"
  if [[ -n $WSL_DISTRO_NAME ]]; then
    alias winpath='wslpath -m'
    source "$BH_DIR/os_win.bash";
  fi
  ;;
darwin*)
  source "$BH_DIR/os_mac.bash"
  ;;
esac

#########################
# load <command>.bash files
#########################

if type adb &>/dev/null; then source "$BH_LIB/adb.bash"; fi
if type cmake &>/dev/null; then source "$BH_LIB/cmake.bash"; fi
if type ffmpeg &>/dev/null; then source "$BH_LIB/ffmpeg.bash"; fi
if type gs &>/dev/null; then source "$BH_LIB/gs.bash"; fi
if type git &>/dev/null; then source "$BH_LIB/git.bash"; fi
if type lxc &>/dev/null; then source "$BH_LIB/lxc.bash"; fi
if type meson &>/dev/null; then source "$BH_LIB/meson.bash"; fi
if type pandoc &>/dev/null; then source "$BH_LIB/pandoc.bash"; fi
if type python &>/dev/null; then source "$BH_LIB/python.bash"; fi
if type wget &>/dev/null; then source "$BH_LIB/wget.bash"; fi
if type youtube-dl &>/dev/null; then source "$BH_LIB/youtube-dl.bash"; fi