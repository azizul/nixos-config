{
  lib,
  inputs,
  system,
  config,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    qt5.full
    obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    })
  ];

  environment.variables = {
    NIXPKGS_ALLOW_INSECURE = "1";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
  ];
}
