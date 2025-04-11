{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:
{
  hm.programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
