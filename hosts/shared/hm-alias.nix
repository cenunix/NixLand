{ lib, config, ... }:

{
  options.hm = lib.mkOption {
    type = lib.types.attrs;
    description = "Shortcut alias to home-manager.users.cenunix.";
  };

  config.hm = config.home-manager.users.cenunix;
}
