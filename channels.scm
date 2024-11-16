(cons* (channel
        (name 'emacs-master)
        (url "https://codeberg.org/akib/guix-channel-emacs-master")
        (branch "master")
        (introduction
         (make-channel-introduction
          "1ba8c40e21c1c18f70c8ff116f2fbbbb41a5a30a"
          (openpgp-fingerprint
           "C954 CA9A BB4B EA43 417B  7151 5535 FCF5 4D88 616B"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       %default-channels)
