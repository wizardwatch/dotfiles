# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # edit the version of discord. I could not get it to work. 
  #version = "0.0.121";
  #nixpkgs.overlays = [(self: super: { discord = super.discord-canary.overrideAttrs (_: { src = builtins.fetchTarball https://dl-canary.discordapp.net/apps/linux/0.0.121/discord-canary-0.0.121.tar.gz; });})];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # sacrifice freedom for ease
  nixpkgs.config = {
    allowUnfree = true;
  };
  # let me install random packages from githubs. Like the AUR, but even less secure!
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };
  # Use the systemd-boot EFI boot loader. no touchy
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
  networking.interfaces.enp0s31f6.ipv4.addresses = [ {
    address = "192.168.1.169";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.146" "1.1.1.1" ];
  # networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # No more x! No more x!
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = false;

  # Enable the GNOME 3 Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    #shell = pkgs.nushell;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
	environment.systemPackages = with pkgs; [
    ## password entry for gui applications
    polkit_gnome
    ## source control; linus style
		git
    ## get the web, from your own computer
		wget
    ## firefox with a touch of the farside
		firefox-wayland
    ### UNFREE ###
    # dam discord and their tos. I want a decent client. 
    discord-canary
    ### Free ###
    ## bloat just got bloated
    # electron
    ## the text editor of the past, today
    emacs
    ## monitor all the things, except gpu usage
		htop
    ## python
    python39
    ## is it wrong to use a pulse audio tool with pipewire
		pavucontrol
    ## emacs thing I think. no touchy
    ripgrep
    ## stupid noncompliant websites
    chromium
    ### emacs deps
    # for emacs pdfs
    poppler
    # for emacs latex
    texlive.combined.scheme-full
    # for emacs github/magit forge
    gnupg
    # for decrypting .authinfo
    pinentry-emacs
    pinentry
    ## no longer using nushell. It is too nu
    nushell
    ## the prefered way to install rust
    rustup
    ## god I hate java
    # jdk11
    ## those videos aren't going to download themselves!
    youtube-dl
    ## if only I could draw
    krita
    ## emacs and other stuff dependency. 
    sqlite
    ## pipewire equalizer
    pulseeffects-pw
    ## local password manager. Replaced by 'the cloud'
    # pass
    ## Spell check only tested in emacs
    hunspell
    hunspellDicts.en_US-large
    ## desktop notifications
    libnotify
    ## terminal pdf compressor
    ghostscript
    ## file browser
    gnome3.nautilus
    # doesn't work due to a lack of the overall gnome package group
    # gnome3.gnome-tweak-tool
    ## krita fix icons
    breeze-icons
    ## java extra credit
    # greenfoot
    ## remote into ras-pi
    nomachine-client
    ## doesn't seem to work on wayland
    #lxappearance
    obs-studio
    ## obs for wlroots
    obs-wlrobs
    ## password manager
    bitwarden
    bitwarden-cli
    ## email, like snail mail, but harder to block the spam!
    mailspring
    ## personal site
    nodePackages.gatsby-cli
    nodePackages.npm
    nodejs
    autoconf
    automake
    libtool
    libtool_1_5
    autogen
    autobuild
    coreutils-full
    pkgconfig
    nasm
    libpng
    dpkg
    gettext
    intltool
    mozjpeg
    ## boring work just got a little more mundane
    libreoffice-fresh
    ## HSCTF
    hping
    nmap
    masscan
    openvpn
    curlFull
    dig
    mitmproxy
    p0f
    hcxdumptool
    hcxtools
    bully
    aircrack-ng
    smbclient
    openssl
    hashcat
    john
    file
    exiftool
    hexdump
    vim
    binutils
    gdb-multitarget
    ghidra-bin
    burpsuite
    zap
    ruby
    perl
    python2Full
    thc-hydra
    gobuster
    rsync
    moreutils
    sqlmap
    metasploit
	];
  networking.wireguard.enable = true;
	fonts.fonts = with pkgs; [
    ## for everything except :
    jetbrains-mono
    ## for emacs, duh
		emacs-all-the-icons-fonts
    ## for waybar icons
    font-awesome
    ## for krita, might not need this for you have it above as a pkg, but hey why not
    breeze-icons
    ## non monospaced text sexifier.
    roboto
	];
  fonts.fontconfig.defaultFonts.monospace = [
    "JetBrains Mono"
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "Roboto-Regular"
  ];
  ## fixes some problems problems with pure gtk applications a little bit.
  fonts.fontconfig.hinting.enable = false;
  ## made some fonts look really bad
  #fonts.fontconfig.antialias = false;
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
      ## gtk theme
      dracula-theme
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
        # xdg-desktop-portal-gtk
    	];
      ## fixes gtk themeing so that it uses the .config. set to true in order to use native file pickers
    	gtkUsePortal = false;
		};
	};
	environment.sessionVariables = {
    ### probably not needed due to firefox-wayland
   	MOZ_ENABLE_WAYLAND = "1";
    ### makes emacs use .config instead of the home dir. ~/.config breaks at least sway
	  XDG_CONFIG_HOME = "/home/wyatt/.config";
    ### shouldn't be needed but some software is bad
   	XDG_CURRENT_DESKTOP = "sway";
    ### fixes some ugly. TODO: more work on the right numbers
    GDK_SCALE = "1.5";
    GDK_DPI_SCALE = "1";
	};
  
  #
  # flatpak
  #
  # services.flatpak.enable = true;
  
  #
  # pinentry
  #
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "emacs";
  };
  ###
  ### UNFREE
  ###
  # for the games!
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  ###
  ###
  ###
  # Let the passwords be stored in something other than plain text. Required for at least mailspring
  services.gnome.gnome-keyring.enable = true;
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
