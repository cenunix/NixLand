{ lib, ... }:
{
  imports = [
    # Alias hm.* -> home-manager.users.cenunix.*
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "cenunix" ])
  ];
}
