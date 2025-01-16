;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with ‘C-x C-f’ and enter text in its buffer.
;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (gnu system nss) (guix utils) (gnu packages shells))
(use-modules (gnu packages fonts))
(use-modules (guix inferior) (guix channels))
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))
(use-modules (srfi srfi-26))
(use-service-modules cups desktop networking ssh xorg nix)

(define (package-symbols->packages symbols)
  (map (compose specification->package
                symbol->string)
       symbols))

(define (font-symbols->packages symbols)
  (map (compose specification->package
                symbol->string
                (cut symbol-append 'font- <>))
       symbols))

(define %global-packages
  (package-symbols->packages
   '(gvfs git emacs-next vim zsh curl git fastfetch ncurses btop eza zoxide flatpak nix)))

(define %global-fonts
  (font-symbols->packages
   '(jetbrains-mono
     fira-code
     sarasa-gothic dejavu
     wqy-microhei
     gnu-unifont hack wqy-zenhei
     adobe-source-han-sans)))

(operating-system
  (host-name "guix-dulis16p")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (locale "zh_CN.UTF-8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "cn"))

  (users (cons* (user-account
                 (name "duli")
                 (group "duli")
                 (home-directory "/home/duli")
                 (supplementary-groups '("wheel" "netdev" "audio" "video" "users")))
                %base-user-accounts))

  (groups (cons* (user-group
                  (name "duli")
                  (id 1000))
                 %base-groups))

  (packages (append %global-packages
                    %global-fonts
                    %base-packages))

  (services
   (append (list (service nix-service-type)
                 (service gnome-desktop-service-type)
                 (service openssh-service-type
                          (openssh-configuration
                           (permit-root-login #t)))
                 (set-xorg-configuration
                  (xorg-configuration
                   (keyboard-layout keyboard-layout))))
           (modify-services %desktop-services
             (guix-service-type
              config => (guix-configuration
                         (inherit config)
                         (substitute-urls
                          (append '("https://substitutes.nonguix.org"
                                    "https://mirror.sjtu.edu.cn/guix")
                                  %default-substitute-urls))
                         (authorized-keys
                          (append (list (plain-file "non-guix.pub"
                                                    "(public-key
 (ecc
  (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
  )
 )"))
                                  %default-authorized-guix-keys))))
             (gdm-service-type
              config => (gdm-configuration
                         (gnome-shell-assets
                          %global-fonts))))))



  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets '("/boot/efi"))
               (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (uuid "163f461a-4eb9-4bc7-8ac0-ec1f4d8d51dd"))
                         (mount-point "/")
                         (type "btrfs")
                         (options "subvol=root,compress=zstd:1"))
                       (file-system
                         (device (uuid "163f461a-4eb9-4bc7-8ac0-ec1f4d8d51dd"))
                         (mount-point "/home")
                         (type "btrfs")
                         (options "subvol=home,compress=zstd:1"))
                       (file-system
                         (device (uuid "1DBD-DE8F" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems)))
