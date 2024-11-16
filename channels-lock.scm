(list (channel
        (name 'emacs-master)
        (url "https://codeberg.org/akib/guix-channel-emacs-master")
        (branch "master")
        (commit
          "00a88d7d13c3b4a261a6adcc45058ee0507a0997")
        (introduction
          (make-channel-introduction
            "1ba8c40e21c1c18f70c8ff116f2fbbbb41a5a30a"
            (openpgp-fingerprint
              "C954 CA9A BB4B EA43 417B  7151 5535 FCF5 4D88 616B"))))
      (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (commit
          "99574ff94b6fb97794ba720b6fdadf470963dbdc")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "b647d3a149c94ee84cde1af3af7442633afa3416")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
