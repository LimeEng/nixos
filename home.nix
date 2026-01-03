{ config, pkgs, ... }:

{
  home.username = "emil";
  home.homeDirectory = "/home/emil";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  home.file.".zprofile".text = ''
  if [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
  fi
'';


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Desktop applications
    firefox
    vscode

    # CLI utilities
    neofetch
    curl
    which
    tree
    sl
    ffmpeg
    dysk
    nix-output-monitor
    pipes-rs
    cbonsai
  ];

  programs.git = {
    enable = true;
    userName = "Emil Englesson";
    userEmail = "emil@englesson.net";
    extraConfig = {
      init.defaultBranch = "master";
      safe.directory = "/etc/nixos";
   };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "1.0";
      dynamic_background_opacity = false;
    };
  };

  # Hyprland config for better VM compatibility
  home.file.".config/hypr/hyprland.conf".text = ''
    # Set environment variables for better VM compatibility
    env = WLR_NO_HARDWARE_CURSORS,1
    env = WLR_RENDERER_ALLOW_SOFTWARE,1
    
    # Disable animations
    animations {
        enabled = no
    }
    
    # Disable blur and shadows
    decoration {
        blur {
            enabled = no
        }
        drop_shadow = no
    }
  '';

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
