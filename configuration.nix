{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./personal.nix
    ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";            # EFI => nada de /dev/sdX
    #useOSProber = true;          # se quiser detectar Windows/outros
   };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    
    # 2. Habilite o GDM (GNOME Display Manager)
    displayManager.gdm.enable = true;
    #displayManager.gdm.wayland = false;

    # 3. Defina as opções de Autologin
    displayManager.autoLogin = {
      enable = true;
      user = "pio"; # <--- O SEU USUÁRIO AQUI
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";      # usa o layout correto do teclado brasileiro ABNT2
    model = "pc105";
    options = "terminate:ctrl_alt_bksp";
    #options = "nodeadkeys"; # opcional: faz o ~ sair direto sem precisar espaço
  };
  # Garante que o Wayland realmente use a mesma config
  services.xserver.exportConfiguration = true;

  # Wayland / GNOME respeita essas variáveis
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "br";
    #XKB_DEFAULT_VARIANT = "";
    XKB_DEFAULT_VARIANT = "abnt2";
    XKB_DEFAULT_MODEL = "pc105";
    #XKB_DEFAULT_OPTIONS = "terminate:ctrl_alt_bksp";
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

    # Layout base pro Wayland/VTE
    XKB_DEFAULT_LAYOUT = "br";
    XKB_DEFAULT_VARIANT = "abnt2";
    XKB_DEFAULT_MODEL = "pc105";
  
    # ← ESSA É A CHAVE: zera TODAS as opções XKB pro VTE (mata o nodeadkeys fantasma)
    XKB_DEFAULT_OPTIONS = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pio = {
    isNormalUser = true;
    description = "pio";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Habilita o open-vm-tools
  virtualisation.vmware.guest.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  open-vm-tools
  fastfetch
  neovim
  git
  wget
  curl
  starship
  btop
  duf
  eza    
  fd     
  ripgrep
  wl-clipboard
  xsel
  #gnome-terminal
  kitty
  p7zip
  unrar
  unzip
  
  # Ferramentas GNOME
  gnome-tweaks
  gnome-extension-manager
  xdg-user-dirs
  ];

  fonts.packages = with pkgs; [
    inter-nerdfont
    nerd-fonts.cousine
  ];

  # Debloat Gnome
  environment.gnome.excludePackages = with pkgs; [
    geary
    gnome-contacts
    gnome-maps
    gnome-weather
    gnome-music
    simple-scan     
    gnome-calendar
    epiphany
    decibels
    snapshot
    gnome-console
  ];
  services.xserver.excludePackages = with pkgs; [ xterm ];

 # environment.etc."nvim/init.vim".text = ''
 #    "set clipboard=unnamedplus
 #  '';

 # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}
