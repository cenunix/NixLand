{ lib, ... }:
{
  imports = [
    # Only alias hm.cenunix.*  -> home-manager.users.cenunix.*
    (lib.mkAliasOptionModule [ "hm" "cenunix" ] [ "home-manager" "users" "cenunix" ])
  ];
}
