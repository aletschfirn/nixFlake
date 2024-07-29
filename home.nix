{ config, pkgs, ...}: {
    # Initialization section:
    home = {
        username = "aletschfirn";
        homeDirectory = "/home/aletschfirn";
        stateVersion = "24.11";
    };

    # WM section:
    xsession.windowManager = {
        i3 = {
            enable = true;
        };
    };

    # Programs section:
    programs = {
        # zsh section:
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            history.size = 10000;
            history.path = "${config.xdg.dataHome}/zsh/history";

            oh-my-zsh = {
                enable = true;
                theme = "apple";
            };
        };

        # FireFox section:
        firefox = {
            enable = true;
        };

        # TMux section:
        tmux = {
            enable = true;
            mouse = true;
            clock24 = true;
        };

        # alacritty section:
        alacritty.enable = true;

        # Cava section:
        cava = {
            enable = true;
            settings = {
                general = {
                        framerate = 60;
                        lower_cutoff_freq = 20;
                        higher_cutoff_freq = 20000;
                };
                output.alacritty_sync = 1;
                color = {
                    gradient = 1;
                    gradient_color_1 = "'#bf616a'";
                    gradient_color_2 = "'#d08770'";
                    gradient_color_3 = "'#ebcb8b'";
                    gradient_color_4 = "'#a3be8c'";
                    gradient_color_5 = "'#8fbcbb'";
                    gradient_color_6 = "'#88c0d0'";
                    gradient_color_7 = "'#5e81ac'";
                    gradient_color_8 = "'#b48ead'";
                };
            };
        };

        # Git section:
        git = {
            enable = true;
            userName = "aletschfirn";
            userEmail = "alpatovaroslav3@gmail.com";
            lfs.enable = true;
        };
        gh = {
            enable = true;
            gitCredentialHelper = {
                enable = true;
            };
            settings = {
                editor = "hx";
            };
        };

        # Helix section (editor):
        helix = {
            enable = true;
            settings = {
                theme = "nord";
                editor.lsp.display-messages = true;
            };
        };

        # Htop, Btop section:
        htop = {
            enable = true;
            settings = {
                tree_view = 1;
            };
        };
        btop = {
            enable = true;
            settings = {
                color_theme = "Nord";
            };
        };
    };

    # Services section:
    services = {

        # Mako section:
        mako = {
            enable = true;
            backgroundColor = "#434C5EFF";
            textColor = "#ECEFF4FF";
            borderRadius = 10;
            borderSize = 0;
            margin = "25";
            padding = "10";
        };
    };

    # Qt section:
    qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
    };

    # Stylix section:
    stylix = {
        image = ;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        opacity.terminal = 0.75;
        cursor = {
            package = pkgs.nordzy-cursor-theme;
            name = "Nordzy-cursors";
            size = 24;
        };
        fonts = {
          serif = {
            package = pkgs.jetbrains-mono;
            name = "JetBrains Mono";
          };
          sansSerif = {
            package = pkgs.jetbrains-mono;
            name = "JetBrains Mono";
          };
          monospace = {
            package = pkgs.jetbrains-mono;
            name = "JetBrains Mono";
          };
          emoji = {
            package = pkgs.twemoji-color-font;
            name = "Twemoji Color Font";
          };
        };
    };
}