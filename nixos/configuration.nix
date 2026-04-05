# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.initrd.luks.devices."luks-80113675-6c6b-4a0a-8a6f-ed0186ec98ba".device =
    "/dev/disk/by-uuid/80113675-6c6b-4a0a-8a6f-ed0186ec98ba";
  networking.hostName = "nv-nix"; # Define your hostname.

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/mutter" = {
          dynamic-workspaces = false;
          overlay-key = "Super_R";
          workspaces-only-on-primary = true;
        };
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
          gtk-enable-primary-paste = false;
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [
            "compose:ralt"
            "caps:escape"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
          search = [ "<Super>d" ];
          www = [ "<Super>w" ];
          screensaver = [ "<Super>Escape" ];
          home = [ "<Super>e" ];
          help = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "alacritty -e zsh";
          enable-in-lockscreen = false;
          name = "Terminal";
        };
        "org/gnome/desktop/wm/keybindings" = {
          close = [
            "<Super>q"
            "<Alt>F4"
          ];
          move-to-side-n = [ "<Super>Up" ];
          move-to-side-e = [ "<Super>Right" ];
          move-to-side-s = [ "<Super>Down" ];
          move-to-side-w = [ "<Super>Left" ];
          toggle-maximized = [ "<Super>k" ];
          minimize = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          show-desktop = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-input-source = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-input-source-backward = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];
          switch-to-workspace-10 = [ "<Super>0" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" ];
          move-to-workspace-6 = [ "<Super><Shift>6" ];
          move-to-workspace-7 = [ "<Super><Shift>7" ];
          move-to-workspace-8 = [ "<Super><Shift>8" ];
          move-to-workspace-9 = [ "<Super><Shift>9" ];
          move-to-workspace-10 = [ "<Super><Shift>0" ];
        };
        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = pkgs.lib.gvariant.mkUint32 10;
        };
        "org/gnome/mutter.wayland/keybindings" = {
          restore-shortcuts = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          speed = pkgs.lib.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/peripherals/keyboard" = {
          delay = pkgs.lib.gvariant.mkUint32 300;
          repeat = true;
          repeat-interval = pkgs.lib.gvariant.mkUint32 30;
        };
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ "<Super><Shift>s" ];
          switch-to-application-1 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-2 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-3 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-4 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-5 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-6 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-7 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-8 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          switch-to-application-9 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-1 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-2 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-3 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-4 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-5 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-6 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-7 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-8 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
          open-new-window-application-9 = pkgs.lib.gvariant.mkEmptyArray pkgs.lib.gvariant.type.string;
        };
      };
    }
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # User account
  users.users.nv = {
    isNormalUser = true;
    description = "nv";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
    ];
  };

  # Enable zsh with Oh My Zsh
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Essentials
    vim
    git
    gnumake
    gcc
    wget
    ripgrep
    fzf
    unzip
    lsof
    # Dev setup
    stow
    alacritty
    zsh
    tmux
    tmuxinator
    neovim
    lazygit
    opencode
    nerd-fonts.mononoki
    python314
    go
    cargo
    nodejs_24
    # Misc
    firefox
  ];

  system.stateVersion = "25.11";

}
