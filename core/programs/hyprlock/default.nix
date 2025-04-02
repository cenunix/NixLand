{
  inputs,
  osConfig,
  config,
  ...
}:
let
  inherit (config) modules;
  inherit (modules.style.colorScheme) colors;
  font_family = "Inter Nerd Font";
in
{
  # imports = [ inputs.hyprlock.homeManagerModules.default ];
  hm.programs.hyprlock = {
    enable = true;
    # settings = {
    #   background = [
    #     {
    #       monitor = "";
    #       # path = "/home/cenunix/Media/Pictures/wp6257053.jpg";
    #     }
    #   ];
    #
    #   input-field = [
    #     {
    #       monitor = "DP-1";
    #
    #       size = "300, 50";
    #
    #       outline_thickness = 2;
    #
    #       outer_color = "rgb(108, 112, 134)";
    #       inner_color = "rgb(108, 112, 134)";
    #       font_color = "rgb(205, 214, 244)";
    #
    #       fade_on_empty = false;
    #       # placeholder_text =
    #       #   "<span font_family='Lexend' foreground=##cdd6f4>Password...</span>";
    #       dots_spacing = 0.3;
    #       dots_center = true;
    #     }
    #   ];
    #
    #   label = [
    #     {
    #       monitor = "";
    #       # inherit font_family;
    #       # font_family = "Lexend";
    #       # text = ''cmd[update:1000] echo "<span font_family='Lexend' foreground='##cdd6f4'>$(date +%r)</span>"'';
    #       # text = "";
    #       # font_size = 50;
    #       color = "rgb(205, 214, 244)";
    #
    #       position = "0, 80";
    #
    #       valign = "center";
    #       halign = "center";
    #     }
    #   ];
    # };
  };
}
