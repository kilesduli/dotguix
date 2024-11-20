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
(use-modules (gnu) (gnu system nss) (guix utils))
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (locale "en_US.utf8")
 (timezone "Asia/Shanghai")
 (keyboard-layout (keyboard-layout "cn"))
 (host-name "guix-dulis16p")

 (users (cons* (user-account
                (name "duli")
                (comment "duli")
                (group "users")
                (home-directory "/home/duli")
                (supplementary-groups '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))

 (packages (append (map (compose specification->package+output
                                 symbol->string)
                        '(gvfs git emacs-next vim git zsh fastfetch))
                   %base-packages))

 (services
  (append (list (service gnome-desktop-service-type)
                (service openssh-service-type
                         (openssh-configuration
                          (permit-root-login #t)))
                (set-xorg-configuration
                 (xorg-configuration (keyboard-layout keyboard-layout))))
          (modify-services %desktop-services
                           (guix-service-type
                            config => (guix-configuration
                                       (inherit config)
                                       (substitute-urls
                                        (append '("https://substitutes.nonguix.org"
                                                  "https://mirror.sjtu.edu.cn/guix")
                                                %default-substitute-urls)))))))



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
