{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  hm.programs.kitty = {
    enable = true;
    # font.name = "monospace";
    # font.size = 14;
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = 2;
      cursor_shape = "block";
      # url_color = "#89ddff";
      url_style = "dotted";
      #Close the terminal =  without confirmation;
      confirm_os_window_close = 0;
      # background_opacity = "0.7";
      window_padding_width = 10;
    };
  };
}
