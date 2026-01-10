{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    ollama = {
      enable = true;
      # package = pkgs.ollama-cuda;
      host = "127.0.0.1";
      port = 11434;
    };
    open-webui = {
      enable = true;
      host = "127.0.0.1";
      port = 8080;
    };
  };
}
