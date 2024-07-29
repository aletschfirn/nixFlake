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
                userOSProber = true;
            };
            efi.canTouchEfiVariables = true;
        };
    };

    # Networking section:
    networking = {
        hostName = "RyoYamada";
        wireless.enable = true;
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
        doas = {
            enable = true;
            extraRules.aletschfirn.persist = true;
        };
    };

    # XServer section:
    services.xserver = {
        enable = true;
        xkb = {
            layout = "us";
            variant = "";
        };
        displayManager = { startx.enable = true; };
    };

    # NVidia section:
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
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
        homeManagerIntegration = {
            autoImport = true;
            followSystem = true;
        };
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
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