{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = with pkgs; [
      # status bar
      waybar

      # for the (spotify) media buttons
      playerctl

      # for waybar to show the workspaces
      hyprland-workspaces
    ];
  };
}
