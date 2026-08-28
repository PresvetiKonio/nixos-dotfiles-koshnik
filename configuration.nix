{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    cores = 0;
    max-jobs = "auto";
  };
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking.hostName = "koshnik"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  #  hardware.bluetooth.enable = true;
  #  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Sofia";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ACTION=="add", TAG+="uaccess"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # configuration.nix
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "auto";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };
  swapDevices = [
    {
      device = "/dev/nvme0n1p3";
    }
  ];
  boot.resumeDevice = "/dev/nvme0n1p3";
  systemd.sleep.settings.Sleep = {

    hibernateDelaySec = "1h";
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    audio.enable = true;
    alsa.enable = true;
  };
  security.rtkit.enable = true;

  services = {
    libinput.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
  programs.dconf.enable = true;
  programs.xfconf.enable = true;
  services.displayManager.ly.enable = true;
  security.polkit.enable = true;
  programs.sway.enable = true;
  services.tailscale.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.power-profiles-daemon.enable = lib.mkForce false;
  #services.xserver.enable = true;
  #services.xserver.windowManager.qtile.enable = true;
  #
  services.apollo = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.enable = true;
  #services.displayManager.sddm.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # for Steam/Wine, 32-bit games
  };

  # Optional but recommended: Vulkan/OpenGL extra packages

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vladko = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
      "adbusers"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree

    ];
  };

  programs.zsh.enable = true;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    brightnessctl

    gnome-themes-extra
    papirus-icon-theme
  ];

  fonts.packages = with pkgs; [
    font-awesome
    font-awesome_4
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
