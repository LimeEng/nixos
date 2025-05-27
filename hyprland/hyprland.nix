# # hyprland.nix
# { pkgs, config, ... }:

# {
#   programs.hyprland = {
#     enable = true;
#     xwayland.enable = true;
#   };

#   environment.systemPackages = with pkgs; [
#     hyprpaper  # for wallpaper (optional, replace or remove as needed)
#     kitty      # terminal (minimal Wayland-friendly terminal)
#     wayland-utils
#     wl-clipboard
#     grim # screenshot tool (optional)
#     slurp # screenshot selection tool (optional)
#   ];

#   services.xserver.enable = false; # ensure X11 is off if only using Wayland
# }

{ config, lib, pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./waybar.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # additional packages
  environment = {
    systemPackages = with pkgs; [
      # terminal emulator
      kitty

      # application launcher
      rofi-wayland

      # wallpaper manager
      # switching wallpapaers without restart and even animations
      swww

      # pulseaudio volume control
      pavucontrol

      # laptop
      brightnessctl

      # file explorer
      yazi ffmpeg p7zip jq poppler fd ripgrep fzf zoxide imagemagick wl-clipboard
      nautilus

      # qr code generator
      qrencode

      # picture explorer
      libsForQt5.gwenview
      feh

      # notification center
      swaynotificationcenter

      # process monitor
      gtop

      # screenshots
      grimblast feh

      # TODO polkit
    ];
    sessionVariables = {
      # Hint electron apps (Discord etc.) to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };

  # we have to install a login tool, otherwise the user has to manually run hyprland
  services.greetd =
  let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.hyprland}/bin/Hyprland";
    username = "emil";
  in
  {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };
}

