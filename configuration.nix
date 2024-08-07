{ config, lib, pkgs, ...}: {
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./packages.nix
    ];
    system.stateVersion = "24.11"; # If unsure - comment out and paste what is in the error :3

    # Boot section:
    boot = {
        loader = {
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                useOSProber = true;
            };
            efi.canTouchEfiVariables = true;
        };
    };

    # Networking section:
    networking = {
        hostName = "RyoYamada";
        networkmanager.enable = true;
    };

    # Time Zone section::
    time.timeZone = "Europe/Moscow";

    # Language section:
    i18n.defaultLocale = "en_US.UTF-8";

    # Sound section:
    sound.enable = true;
    hardware.pulseaudio.enable = false; # Disables useless thing that is somewhy default...
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Bluetooth section:
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
                Experimental = true;
            };
        };
    };
    services.blueman.enable = true;

    # Filesystem section:
    services.fstrim.enable = true;
    zramSwap = {
        enable = true;
        algorithm = "lz4";
        memoryPercent = 50;
        priority = 999;
    };

    # User account section:
    programs.zsh.enable = true;
    users = {
        defaultUserShell = pkgs.zsh;
        users.aletschfirn = { # Change aletschfirn to your nickname
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };
    };
    services.getty.autologinUser = "aletschfirn";

    # Security section:
    security = {
	      polkit.enable = true;
        doas = {
            enable = true;
        };
    };

   # Hyprland modules section:
   programs.hyprland.enable = true;

    # NVidia section:
    hardware.opengl = {
        enable = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    # Env Variables section:
    environment.variables = {
        EDITOR = "hx";
        QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    # Stylix section:
    stylix = {
	    enable = true;
      autoEnable = false;
	    image = pkgs.fetchurl {
        url = "https://github.com/dharmx/walls/blob/main/digital/a_foggy_mountain_with_trees.jpg";
        sha256 = "14dwaqv26dwhjsnbvscjlnsrrdw9rx6fqgrhfxhbr49rvalv79kx";
      };  
      homeManagerIntegration = {
            autoImport = true;
            followSystem = true;
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      targets = {
        console.enable = true;
        grub.enable = true;
        gtk.enable = true; 
      };
    
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

    # Nix section:
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config = {
        allowUnfree = true;
    };
}
