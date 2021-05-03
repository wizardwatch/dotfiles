# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME 3 Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  hardware.pulseaudio.enable = false;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wyatt = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
	environment.systemPackages = with pkgs; [
 		polkit_gnome	
		git    
		wget
		firefox-wayland
    ### UNFREE ###
    discord-canary
    ### Free ###
    electron
    emacs
		htop
    python39
		pavucontrol
    ripgrep
    chromium
    # for parsec maybe
    flatpak
    ### emacs deps
    # for emacs pdfs
    poppler
    # for emacs latex
    texlive.combined.scheme-full
    # for emacs github/magit forge
    gnupg
    pinentry-emacs
    pinentry
    ###
    nushell
    rustup
    jdk11
    youtube-dl
    krita
    sqlite
    pulseeffects-pw
    pass
    ## Spell check only teted in emacs
    hunspell
    hunspellDicts.en_US-large
    ## desktop notifications
    libnotify
    ## terminal pdf compressor
    ghostscript
	];
	fonts.fonts = with pkgs; [
		jetbrains-mono
		emacs-all-the-icons-fonts
    font-awesome
	];
	programs.sway = {
  	enable = true;
 		wrapperFeatures.gtk = true; # so that gtk works properly
		extraPackages = with pkgs; [
		  swaylock
		  swayidle
		  wl-clipboard
		  waybar
		  clipman
		  xwayland
		  mako # notification daemon
		  alacritty # Alacritty is the default terminal in the config
   	  wofi
		  oguri
		  grim
		  slurp
  	];
	};
	#
	# pipewire
	# 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
	#
	# XDG-desktop-screenshare
	#
	xdg = {
  	portal = {
    	enable = true;
    	extraPortals = with pkgs; [
      	xdg-desktop-portal-wlr
      	xdg-desktop-portal-gtk
    	];
    	gtkUsePortal = true;
		};
	};
	environment.sessionVariables = {
   	MOZ_ENABLE_WAYLAND = "1";
   	XDG_CURRENT_DESKTOP = "sway"; 
	};
  #
  # pinentry
  #
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "emacs";
  };
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  #programs.gnupg.agent.pinentryFlavor = "emacs";
    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
