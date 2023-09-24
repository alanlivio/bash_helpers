<h1 align="center"><img src="logo.svg" width="250" onerror='this.style.display="none"'/></h1>

# bash-helpers

Template to easily create multi-OS bash helpers for Windows (MSYS2/GitBash/WSL), Ubuntu, and Mac. It is useful to let you organize helpers in `OS-dependent` or `command-dependent`. Diagram below ilustrate how the [init.sh](init.sh) load `OS-dependent` from `os_*.bash` (files after testing `$OSTYPE`) and load `command-dependent` from `commands/*.bash` (after testing `type <command>`).
The project logo refers to the synthetic chemical element Bohrium, which also has BH's initials.

```mermaid
%%{init: {'theme':'dark'}}%%
flowchart LR
    bashrc["~/.bashrc"]
    init["bash-hepers/init.sh"]
    anyos["os_any.bash"]
    command-dependent["
        commands/[cmd_name].bash
        ...
    "]
    win["os_win.bash"]
    ubu["os_ub.bash"]
    mac["os_mac.bash"]
    scripts_sh["
        scripts/[script].sh
        ...
    "]
    scripts_ps1["
        scripts/win_[script].ps1
        ...
    "]
    bashrc --> |"load"| init
    init --> |"load"| anyos
    anyos --> |"alias to each *.sh"| scripts_sh
    anyos --> |"load if cmd_name"| command-dependent
    win --> |"alias to each win_*.ps1"| scripts_ps1
    init --> |"load if $OSTYPE==msys* || -n $WSL_DISTRO_NAME"| win
    init --> |"load if $OSTYPE==linux*"| ubu
    init --> |"load if $OSTYPE==mac*"| mac
```

## Install

The bash-helpers project has two requirements: a `bash shell` and `git`. So, run on a `bash shell` with `git`:

```bash
  git clone https://github.com/alanlivio/bash-helpers ~/.bh &&\
    echo "source ~/.bh/init.sh" >> ~/.bashrc &&\
    source ~/.bashrc
```

Alternative, you can see the [skel/.bashrc](skel/.bashrc) as example.

On Win, you run the above command at GitaBash installed with [GitForWindows](https://gitforwindows.org). If you also use WSL, you can share the same BH repo by doing a symbolic link to it with `ln -s /mnt/c/<user>/.bh ~/.bh`.

## OS-dependent samples

### os_any

* `dotfiles_backup`: backup files/dirs defined in BH_DOTFILES.
* `dotfiles_diff`: show diff files/dirs defined in BH_DOTFILES.
* `dotfiles_install`: restore files/dirs defined in BH_DOTFILES.
* `decompress_from_url`: fetch and decompress to a given folder.
* `decompress`: decompress from multiple formats to a given folder.
* `folder_count_files`: count files in the current folder.
* `folder_count_files_recursive`: count files in the current and subfolder.
* `folder_sorted_by_size`: list dir sorted by item size.
* `user_sudo_nopasswd`: disable password when calling sudo (user must be in sudoers).

Some of the above helpers use `BH_*` vars from `~/.bashrc`, see examples at [skel/.bashrc](skel/.bashrc).
See more OS-independent helpers  [os_any.bash](os_any.bash) folder.

### os_ubu

* `ubu_update`: update os and apt packages. If defined BH_PKGS_APT, install them.
* `gnome_sanity`: enable dark mode, disable animations, clean taskbar (e.g., small icons), uninstall pre-installed and not used apps (e.g., weather, news, calendar, solitaire).
* `deb_install_url`: fetch and install a deb package.

See more Ubuntu helpers in [os_ubu.bash](os_ubu.bash).

### os_mac

* `mac_update`: update os and brew packages. If defined BH_PKGS_BREW, install them.
* `mac_install_brew`: install brew package manager

See more Mac helpers in [os_mac.bash](os_mac.bash).

### os_win

* `win_update`: update os and winget packages. If defined BH_PKGS_WINGET, install them.
* `win_path_show`: show windows path as list.
* `win_ssh_add_identity`: set ssh-agent to automatically startup and add $HOME/.ssh/id_rsa as Identity.
* `winpath`: get current path in Windows format. It uses `cygpath -m` in GitBash/MSYS2, while uses `wslpath -m` in WSL.
* `win_policy_reset`: reset group policy.
* `win_disable_apps_preinstalled`: remove unused apps. It is a wrapper [win_disable_apps_preinstalled.ps1](scripts/win_disable_apps_preinstalled.ps1).
* `win_disable_hotkeys`disable accessibility, rotation, lang hotkeys. It is a wrapper [win_disable_hotkeys.ps1](scripts/win_disable_hotkeys.ps1).
* `win_disable_password_policy`: disable password policy requirement. It is a wrapper [win_disable_password_policy.ps1](scripts/win_disable_password_policy.ps1).
* `win_disable_pc_folders`: disable link folders on This PC. It is a wrapper [win_disable_pc_folders.ps1](scripts/win_disable_pc_folders.ps1).
* `win_disable_sounds`: disable systems sound (e.g., bells). It is a wrapper [win_disable_sounds.ps1](scripts/win_disable_sounds.ps1).
* `win_enable_hyper_v`: enable hyper-v virtualization. It is a wrapper [win_enable_hyper_v.ps1](scripts/win_enable_hyper_v.ps1).
* `win_disable_search_service`: disable Windows Search service (e.g., bells). It is a wrapper [win_disable_sounds.ps1](scripts/win_disable_search_service.ps1).
* `win_disable_web_search_and_widgets`: disable Windows Web search and Widgets. It is a wrapper [win_enable_hyper_v.ps1](scripts/win_disable_web_search_and_widgets.ps1).
* `win_path_add`: add dir to the path. It is a wrapper [win_path_add.ps1](scripts/win_path_add.ps1).
* `win_env_add`: add variable to env variables.
* `win_env_show`: show env variables.
* `win_home_hide_dotfiles`: set as hidden files starting with "." at home folder
* `regedit_open_shell_folders`: open regedit in current Gusers shell folder settings
* `start_from_wsl`: (from wsl): call `start` from cmd.
* `msys2_search`: search for msys2 package
* `msys2_list_installed`: list installed msys2 packages.
* `msys2_use_same_home`: set msys2 to use the same home as a Windows user.
* `msys2_show`: show pkg info
* `msys2_install`: install pkg
* `msys2_uninstall`: uninstall pkg
* `msys2_use_same_home`: setup to use same home as Windows user

See more Win helpers in [os_win.bash](os_win.bash).

## command-dependent samples

### Python

* `python_clean_cache`: clean cache
* `python_check_tensorflow`: check Tensorflow GPU support.
* `python_setup_install_local`: install from a pkg folder with setup.py.
* `python_setup_upload_testpypi`: upload to [testpypi repository](https://test.pypi.org/) from a pkg folder with setup.py.
* `python_setup_upload_pip`: upload to pip from a pkg folder with setup.py.
* `conda_env_create_from_enviroment_yml`: create env from environment.yml.
* `conda_env_update_from_enviroment_yml`: update env from environment.yml.

See more helpers in [commands/python.bash](commands/python.bash).

### convert

* `convert_heic_to_jpg_at_dir`: use imagemagick convert to convert *.heic to jpg.
* `convert_pptx_compress_images`: extract pptx images, use imagemagick to compresse then and create a new pptx file.

### Docker

* `docker_prune`: clean unused images and containers
* `docker_run_at_same_folder`: run, from an image, a command line using the current folder as the working folder

See more helpers in [commands/docker.bash](commands/docker.bash).

### others

See other commands at:

* [commands/adb.bash](commands/adb.bash).
* [commands/cmake.bash](commands/cmake.bash).
* [commands/ffmpeg.bash](commands/ffmpeg.bash).
* [commands/git.bash](commands/git.bash).
* [commands/gs.bash](commands/gs.bash).
* [commands/lxc.bash](commands/lxc.bash).
* [commands/meson.bash](commands/meson.bash).
* [commands/pandoc.bash](commands/pandoc.bash).
* [commands/wget.bash](commands/wget.bash).
* [commands/youtube-dl.bash](commands/youtube-dl.bash).

## References

This project takes inspiration from:

* <https://github.com/Bash-it/bash-it>
* <https://github.com/milianw/shell-helpers>
* <https://github.com/wd5gnr/bashrc>
* <https://github.com/martinburger/bash-common-helpers>
* <https://github.com/jonathantneal/git-bash-helpers>
* <https://github.com/donnemartin/dev-setup>
* <https://github.com/aspiers/shell-env>
* <https://github.com/nafigator/bash-helpers>
* <https://github.com/TiSiE/BASH.helpers>
* <https://github.com/midwire/bash.env>
* <https://github.com/e-picas/bash-library>
* <https://github.com/awesome-windows11/windows11>
* <https://github.com/99natmar99/Windows-11-Fixer>
* <https://github.com/W4RH4WK/Debloat-windows-10/tree/master/scripts>
