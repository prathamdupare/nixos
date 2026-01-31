#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # this line bro
    ./modules/nixvim/defaults.nix
  ];

  home-manager.users.pratham = {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    home.packages = [
      pkgs.atool
      pkgs.httpie
    ];
    services.vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        theme.name = "tokyo-night";
        font.size = 11;
        faviconService = "twenty";
        popToRootOnClose = false;
        rootSearch.searchFiles = false;
        window = {
          csd = true;
          opacity = 0.75;
          rounding = 10;
        };
      };
    };
    home.stateVersion = "25.11";

    services.mpd = {
      enable = true;
      musicDirectory = "/home/pratham/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
            name "PipeWire"
        }
      '';
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "uinput" ];

fileSystems."/mnt/data" = {
  device = "/dev/disk/by-uuid/CACCD7B9CCD79DCF";
  fsType = "ntfs-3g";
  options = [ "rw" "uid=1000" "gid=1000" "nofail" "windows_names" ];
};


  # Add uinput module for Kanata

  programs.kdeconnect.enable = true;

  programs.zsh.ohMyZsh = {
    theme = "robbyrussell";
    plugins = [
      "git"
      "sudo"
      "vi-mode"
      "zsh-history-substring-search"
    ];

  };
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/home/pratham/Music";
      Address = "0.0.0.0";
      Port = 4533;
      BaseUrl = "";
      EnableSharing = true;
    };
  };
  systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce false;
  services.udisks2.enable = true;
  services.gvfs.enable = true;


  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "pratham";
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "pratham";
      };
    };
  };
  services.upower.enable = true;

  services.blueman.enable = true;
  services.tailscale.enable = true;


  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # Enable uinput for Kanata
  hardware.uinput.enable = true;
  hardware.bluetooth.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false; # Don't start at boot
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable unfree packages (required for NVIDIA drivers)
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    127.0.0.1 screenshot.local
  '';
  networking.firewall = {
  enable = true;
  allowedTCPPortRanges = [
  {
    from = 1714;
    to = 1764;
  } # KDE Connect
  ];
  allowedUDPPortRanges = [
  {
    from = 1714;
    to = 1764;
  } # KDE Connect
  ];
};

  programs.nix-ld.enable = true;
  programs.adb.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.flatpak.enable = true;
  services.snap.enable = false;

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];

  # NVIDIA Configuration (following official NixOS guide)
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Enable 32-bit support for Steam, etc.
  };

  # Load nvidia driver for Xorg and Wayland

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (recommended for Turing+)
    # GTX 1650 Mobile is Turing architecture (TU117M), so open drivers are recommended
    open = true;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Driver version - use stable for reliability
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Optimus PRIME Configuration for laptops
    prime = {
      # Offload mode - saves power, use NVIDIA only when needed
      offload = {
        enable = true;
        enableOffloadCmd = true; # This creates the nvidia-offload command
      };

      # Bus IDs from your lspci output
      amdgpuBusId = "PCI:5:0:0"; # AMD Renoir Vega
      nvidiaBusId = "PCI:1:0:0"; # NVIDIA GTX 1650 Mobile
    };
  };

  services.create_ap = {
    enable = false;
    settings = {
      INTERNET_IFACE = "eth0";
      WIFI_IFACE = "wlan0";
      SSID = "Pratham-NixOS";
      PASSPHRASE = "Fairbanks";
    };
  };

  services.postgresql = {
    enable = false;

    package = pkgs.postgresql_16; # Force PG 16.4 here
    ensureDatabases = [ "mydatabase" ];
    extraPlugins = with pkgs.postgresql_16.pkgs; [
      timescaledb
      # Add other extensions like postgis if needed
    ];

    settings = {
      shared_preload_libraries = "timescaledb";
    };
    authentication = pkgs.lib.mkOverride 10 ''
      # Allow local connections via Unix sockets without authentication
      local   all             all             trust

      # Allow IPv4 local connections with password authentication
      host    all             all             127.0.0.1/32            md5

      # Allow IPv6 local connections with password authentication
      host    all             all             ::1/128                 md5
    '';
  };

  # Enable the GNOME Desktop Environment.

  #services.displayManager.sddm = {
  #  enable = true;
  #  theme = "sddm-astronaut-theme";
  #  wayland.enable = true;
  #};

  # Configure keymap in X11

  # Enable CUPS to print documents.
  services.printing.enable = false;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.pam.services.hyprlock = { };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.pratham = {
    isNormalUser = true;
    description = "Pratham";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "uinput"
    ]; # Added uinput group
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Install firefox.

  programs.steam.enable = true;
  programs.firefox.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };
  };

  # Install Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprlock.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    kitty
    foot
    xdg-desktop-portal-hyprland
    wl-clipboard
    glibc
    git
    waybar
    wofi
    chromedriver
    brightnessctl
    alsa-utils
    xfce.thunar
    mako
    libgcc
    zig
    swaybg
    killall
    tmux
    pywal
    libnotify
    flatpak
    go
    gcc
    zsh
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    gnome-bluetooth
    bluetuith
    nodejs_22
    lua
    lazygit
    gnumake
    unzip
    ripgrep
    ghostty
    localsend
    fastfetch
    bun
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    android-studio
    jdk
    pavucontrol
    lutris-unwrapped
    yarn
    yazi
    hyprlock
    hypridle
    mpv
    udiskie
    mpc

    jmtpfs



    # GPU utilities
    vulkan-tools
    pciutils
    mangohud
    protonup-ng
    protonup-qt
    heroic
    lutris
    wineWowPackages.stable
    wine
    greetd.tuigreet
    winetricks
    # JellyFin
    rmpc
    rustc
    cargo
    brave
    gimp
    yt-dlp
    nicotine-plus
    nautilus
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPACT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
