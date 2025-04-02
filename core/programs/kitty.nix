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
      url_color = "#89ddff";
      url_style = "dotted";
      #Close the terminal =  without confirmation;
      confirm_os_window_close = 0;
      # background_opacity = "0.7";
      window_padding_width = 10;
    };
    extraConfig = ''
      mouse_hide_wait 0
      # The basic colors
       foreground              #CDD6F4
       background              #07070b
       selection_foreground    #07070b
       selection_background    #F5E0DC

       # Cursor colors
       cursor                  #F5E0DC
       cursor_text_color       #07070b

       # URL underline color when hovering with mouse
       url_color               #F5E0DC

       # Kitty window border colors
       active_border_color     #B4BEFE
       inactive_border_color   #6C7086
       bell_border_color       #F9E2AF

       # OS Window titlebar colors
       wayland_titlebar_color system
       macos_titlebar_color system

       # Tab bar colors
       active_tab_foreground   #0a0a10
       active_tab_background   #CBA6F7
       inactive_tab_foreground #CDD6F4
       inactive_tab_background #181825
       tab_bar_background      #0a0a10

       # Colors for marks (marked text in the terminal)
       mark1_foreground #1E1E2E
       mark1_background #B4BEFE
       mark2_foreground #1E1E2E
       mark2_background #CBA6F7
       mark3_foreground #1E1E2E
       mark3_background #74C7EC

       # The 16 terminal colors

       # black
       color0 #45475A
       color8 #585B70

       # red
       color1 #F38BA8
       color9 #F38BA8

       # green
       color2  #A6E3A1
       color10 #A6E3A1

       # yellow
       color3  #F9E2AF
       color11 #F9E2AF

       # blue
       color4  #89B4FA
       color12 #89B4FA

       # magenta
       color5  #F5C2E7
       color13 #F5C2E7

       # cyan
       color6  #94E2D5
       color14 #94E2D5

       # white
       color7  #BAC2DE
       color15 #A6ADC8'';
  };
}
