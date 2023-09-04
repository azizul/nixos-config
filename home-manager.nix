{ config, pkgs, inputs, ... }:

inputs.home-manager.nixosModules.home-manager {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      user.zizu =
        {
          # allow non-free software installation
          nixpkgs.config.allowUnfree = true;

          # Home Manager needs a bit of information about you and the paths it should
          # manage.
          home.username = "zizu";
          home.homeDirectory = "/home/zizu";

          # This value determines the Home Manager release that your configuration is
          # compatible with. This helps avoid breakage when a new Home Manager release
          # introduces backwards incompatible changes.
          #
          # You should not change this value, even if you update Home Manager. If you do
          # want to update the value, then make sure to first check the Home Manager
          # release notes.
          home.stateVersion = "23.05"; # Please read the comment before changing.

          # overlays
          #services.emacs.package = pkgs.emacs-unstable;
          #nixpkgs.overlays = [
          #  (import (builtins.fetchTarball {
          #    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
          #  }))
          #];


          # The home.packages option allows you to install Nix packages into your
          # environment.
          home.packages = [
            # # Adds the 'hello' command to your environment. It prints a friendly
            # # "Hello, world!" when run.
            # pkgs.hello

            # # It is sometimes useful to fine-tune packages, for example, by applying
            # # overrides. You can do that directly here, just don't forget the
            # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
            # # fonts?
            # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

            # # You can also create simple shell scripts directly inside your
            # # configuration. For example, this adds a command 'my-hello' to your
            # # environment:
            # (pkgs.writeShellScriptBin "my-hello" ''
            #   echo "Hello, ${config.home.username}!"
            # '')

            # shell
            pkgs.thefuck
            pkgs.keychain
            pkgs.rmlint
            pkgs.rsync
            pkgs.ncdu
            pkgs.btop
            pkgs.rlwrap
            pkgs.tree

            # git TUI
            pkgs.lazygit

            # editor
            pkgs.neovim
            pkgs.helix
            pkgs.vscode
            #pkgs.emacs-unstable
            pkgs.emacs29

            # programming language
            pkgs.sqlite
            pkgs.python3
            pkgs.sbcl
            pkgs.zig
            pkgs.zls
            pkgs.rustup
            pkgs.llvm
            pkgs.openjdk
            pkgs.maven
            pkgs.gradle

            # web browsing
            pkgs.firefox
            pkgs.vieb
            # creative tools
            pkgs.gimp
            pkgs.krita
            pkgs.musescore
            pkgs.calibre

            # video and audio
            pkgs.pavucontrol
            pkgs.vlc
            pkgs.audacious
          ];


          # Home Manager is pretty good at managing dotfiles. The primary way to manage
          # plain files is through 'home.file'.
          home.file = {
            # # Building this configuration will create a copy of 'dotfiles/screenrc' in
            # # the Nix store. Activating the configuration will then make '~/.screenrc' a
            # # symlink to the Nix store copy.
            # ".screenrc".source = dotfiles/screenrc;

            # # You can also set the file content immediately.
            # ".gradle/gradle.properties".text = ''
            #   org.gradle.console=verbose
            #   org.gradle.daemon.idletimeout=3600000
            # '';
          };

          # You can also manage environment variables but you will have to manually
          # source
          #
          #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
          #
          # or
          #
          #  /etc/profiles/per-user/zizu/etc/profile.d/hm-session-vars.sh
          #
          # if you don't want to manage your shell through Home Manager.
          home.sessionVariables = {
            EDITOR = "vim";
          };

          # Let Home Manager install and manage itself.
          programs.home-manager.enable = true;

          # enable git and set the configuration
          programs.git = {
            enable = true;
            userName = "Azizul Rahman Bin Azizan";
            userEmail = "azizul.rahman.azizan@gmail.com";
          };

          # enable zsh and extra configs
          programs.zsh = {
            enable = true;
            shellAliases = {
              ll = "ls -l";
              os-update = "sudo nixos-rebuild switch";
              os-config = "sudo vim /etc/nixos/configuration.nix";
              hm-update = "home-manager switch";
              hm-config = "vim ~/.config/home-manager/home.nix";
            };
            history = {
              size = 1000;
              path =  "${config.xdg.dataHome}/zsh/history";
            };
            oh-my-zsh = {
              enable = true;
              plugins = [ "git" "thefuck" ];
              theme = "robbyrussell";
            };
            initExtra =
              ''
      eval `keychain --eval --agents ssh id_ed25519`
      '';
          };
        }
          
    };
  }
  
