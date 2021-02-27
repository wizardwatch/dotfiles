;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)
(use-package-modules 
  vim 
  gnuzilla 
  xdisorg 
  rust 
  wm 
  terminals 
  certs
  version-control)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix")
  (users (cons* (user-account
                  (name "wyatt")
                  (comment "Wyatt Osterling")
                  (group "users")
                  (home-directory "/home/wyatt")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages (append (list 
	;; devops tools
	git
	;; text editors
	vim
	;; web browsers
	icecat
	;; launchers
	wofi
	;; programming languages
	rust
	;; window managers
	sway
	;; terminal emulator
	alacritty
	;; for https access
	nss-certs)
      	%base-packages))
  (services
    (append
      (list (service gnome-desktop-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (uuid "056cfe36-2daa-4dec-b8e1-e465f4fd7970")))
  (file-systems
    (cons* (file-system
             (mount-point "/boot/efi")
             (device (uuid "4A01-9938" 'fat32))
             (type "vfat"))
           (file-system
             (mount-point "/")
             (device
               (uuid "608954ec-8237-4455-9038-8105a970811e"
                     'ext4))
             (type "ext4"))
           %base-file-systems)))
