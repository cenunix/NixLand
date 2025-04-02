{
  inputs,
  pkgs,
  config,
  osConfig,
  self,
  lib,
  ...
}:
with lib;
{
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay
  ];
  hm = {
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;
      overwrite.enable = true;

      layout = {
        bar.layouts = {
          "0" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "network"
              "ram"
              "weather"
              "hyprsunset"
              "bluetooth"
              "systray"
              "clock"
              "notifications"
            ];
          };
          "1" = {
            left = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "ram"
              "weather"
              "hyprsunset"
              "clock"
              "notifications"
            ];
          };
        };
      };

      override = {
        theme = {
          bar = {
            background = "#07070b";

            menus = {
              background = "#07070b";
              cards = "#11111b";
              text = "#cdd6f4";

              menu = {
                power = {
                  buttons = {
                    sleep = {
                      icon = "#89b4fa";
                      text = "#cdd6f4";
                    };
                    logout = {
                      icon = "#89b4fa";
                      text = "#cdd6f4";
                    };
                    restart = {
                      icon = "#89b4fa";
                      text = "#cdd6f4";
                    };
                    shutdown = {
                      icon = "#89b4fa";
                      text = "#cdd6f4";
                    };
                  };
                };

                dashboard = {
                  controls = {
                    input = {
                      text = "#cdd6f4";
                      background = "#1e1e2e";
                    };
                    volume = {
                      text = "#cdd6f4";
                      background = "#1e1e2e";
                    };
                    notifications = {
                      text = "#cdd6f4";
                      background = "#1e1e2e";
                    };
                    bluetooth = {
                      text = "#cdd6f4";
                      background = "#1e1e2e";
                    };
                    wifi = {
                      text = "#cdd6f4";
                      background = "#1e1e2e";
                    };
                  };
                  shortcuts = {
                    text = "#cdd6f4";
                  };
                  powermenu = {
                    confirmation = {
                      body = "#cdd6f4";
                    };
                    sleep = "#1e1e2e";
                    logout = "#1e1e2e";
                    restart = "#1e1e2e";
                    shutdown = "#1e1e2e";
                  };
                  card = {
                    color = "#11111b";
                  };
                  background = {
                    color = "#07070b";
                  };
                  profile = {
                    name = "#cdd6f4";
                  };
                  monitors = {
                    disk = {
                      label = "#cdd6f4";
                      bar = "#89b4fa";
                      icon = "#cdd6f4";
                    };
                    gpu = {
                      label = "#cdd6f4";
                      bar = "#89b4fa";
                      icon = "#cdd6f4";
                    };
                    ram = {
                      label = "#cdd6f4";
                      bar = "#89b4fa";
                      icon = "#cdd6f4";
                    };
                    cpu = {
                      label = "#cdd6f4";
                      bar = "#89b4fa";
                      icon = "#cdd6f4";
                    };
                  };
                };

                clock = {
                  text = "#cdd6f4";
                  weather = {
                    hourly = {
                      icon = "#89b4fa";
                      temperature = "#cdd6f4";
                      time = "#cdd6f4";
                    };
                    icon = "#89b4fa";
                    thermometer = {
                      extremelycold = "#89dceb";
                      cold = "#89b4fa";
                      moderate = "#b4befe";
                      hot = "#fab387";
                      extremelyhot = "#f38ba8";
                    };
                    stats = "#cdd6f4";
                    status = "#cdd6f4";
                    temperature = "#cdd6f4";
                  };
                  calendar = {
                    contextdays = "#585b70";
                    days = "#cdd6f4";
                    currentday = "#cdd6f4";
                    paginator = "#89b4fa";
                    weekdays = "#cdd6f4";
                    yearmonth = "#cdd6f4";
                  };
                  time = {
                    timeperiod = "#cdd6f4";
                    time = "#cdd6f4";
                  };
                  border = {
                    color = "#313244";
                  };
                  background = {
                    color = "#11111b";
                  };
                  card = {
                    color = "#1e1e2e";
                  };
                };

                battery = {
                  text = "#cdd6f4";
                };

                systray = {
                  dropdownmenu = {
                    text = "#cdd6f4";
                  };
                };

                bluetooth = {
                  text = "#cdd6f4";
                  iconbutton = {
                    active = "#cdd6f4";
                    passive = "#cdd6f4";
                  };
                  icons = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  listitems = {
                    active = "#cdd6f4";
                    passive = "#cdd6f4";
                  };
                  switch = {
                    puck = "#454759";
                    disabled = "#313245";
                    enabled = "#89b4fa";
                  };
                  switch_divider = "#45475a";
                  status = "#6c7086";
                  label = {
                    color = "#cdd6f4";
                  };
                  scroller = {
                    color = "#cdd6f4";
                  };
                  background = {
                    color = "#07070b";
                  };
                  card = {
                    color = "#11111b";
                  };
                };

                network = {
                  text = "#cdd6f4";
                  background = {
                    color = "#07070b";
                  };
                  card = {
                    color = "#11111b";
                  };
                  iconbuttons = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  icons = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  listitems = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  status = {
                    color = "#9399b2";
                  };
                  label = {
                    color = "#cdd6f4";
                  };
                  scroller = {
                    color = "#cdd6f4";
                  };
                  switch = {
                    enabled = "#89b4fa";
                  };
                };

                volume = {
                  text = "#cdd6f4";
                  card = {
                    color = "#11111b";
                  };
                  background = {
                    color = "#07070b";
                  };
                  input_slider = {
                    puck = "#cdd6f4";
                    backgroundhover = "#313244";
                    background = "#313244";
                    primary = "#cdd6f4";
                  };
                  audio_slider = {
                    puck = "#cdd6f4";
                    backgroundhover = "#313244";
                    background = "#313244";
                    primary = "#cdd6f4";
                  };
                  icons = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  iconbutton = {
                    active = "#cdd6f4";
                    passive = "#9399b2";
                  };
                  listitems = {
                    active = "#eba0ab";
                    passive = "#9399b2";
                  };
                  label = {
                    color = "#cdd6f4";
                  };
                };

                notifications = {
                  card = "#11111b";
                  background = "#07070b";
                };

                media = {
                  buttons = {
                    background = "#cdd6f4";
                    inactive = "#313244";
                  };
                  card = {
                    color = "#11111b";
                  };
                  background = {
                    color = "#07070b";
                  };
                  slider = {
                    backgroundhover = "#313244";
                    puck = "#cdd6f4";
                    background = "#313244";
                    primary = "#cdd6f4";
                  };
                  album = "#cdd6f4";
                  timestamp = "#cdd6f4";
                  artist = "#cdd6f4";
                  song = "#cdd6f4";
                };
              };

              dropdownmenu = {
                text = "#cdd6f4";
              };
              buttons = {
                text = "#cdd6f4";
              };
              popover = {
                text = "#cdd6f4";
              };
            };

            buttons = {
              background = "#07070b";

              modules = {
                power = {
                  icon = "#89b4fa";
                };
                weather = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                  background = "#07070b";
                };
                updates = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                kbLayout = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                netstat = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                storage = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                cpu = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                ram = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                  background = "#07070b";
                };
                submap = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                hyprsunset = {
                  background = "#07070b";
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                hypridle = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
                cava = {
                  icon = "#89b4fa";
                };
                microphone = {
                  icon = "#89b4fa";
                  text = "#cdd6f4";
                };
              };

              notifications = {
                icon = "#89b4fa";
                background = "#07070b";
                text = "#cdd6f4";
              };
              clock = {
                icon = "#89b4fa";
                text = "#cdd6f4";
                background = "#07070b";
              };
              battery = {
                icon = "#89b4fa";
                text = "#cdd6f4";
              };
              systray = {
                customIcon = "#89b4fa";
                background = "#07070b";
              };
              bluetooth = {
                icon = "#89b4fa";
                text = "#cdd6f4";
                background = "#07070b";
              };
              network = {
                icon = "#89b4fa";
                text = "#cdd6f4";
                background = "#07070b";
              };
              volume = {
                icon = "#89b4fa";
                text = "#cdd6f4";
                background = "#07070b";
              };
              media = {
                icon = "#89b4fa";
                text = "#cdd6f4";
                background = "#07070b";
              };
              windowtitle = {
                icon = "#89b4fa";
                text = "#cdd6f4";
              };
              dashboard = {
                icon = "#89b4fa";
                background = "#07070b";
              };
              icon = "#89b4fa";
              text = "#cdd6f4";
              workspaces = {
                background = "#07070b";
                active = "#89b4fa";
                hover = "#89b4fa";
                occupied = "#89dceb";
                available = "#181825";
              };
            };

            osd = {
              icon = "#89b4fa";
            };

            notification = {
              labelicon = "#89b4fa";
              text = "#cdd6f4";
            };
          };
        };
      };

      settings = {
        bar = {
          clock.format = "%a %b %d  %I:%M %p";
          launcher.autoDetectIcon = true;
        };

        menus = {
          dashboard = {
            shortcuts.enabled = false;
            directories.enabled = false;
            stats.enable_gpu = true;
          };

          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };

            weather = {
              unit = "imperial";
              key = "adbcdae597534595a7771155250703";
              location = "Alderwood Manor";
            };
          };

          transition = "slide_down";
          transitionTime = 100;
        };

        theme = {
          font.name = "Inter";
          font.size = "0.85rem";
          bar.transparent = true;
          bar.outer_spacing = "0.2em";
        };
      };

    };
  };
}
