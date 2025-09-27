{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:
{
  hm.cenunix.programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
