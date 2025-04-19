{
  description = "PG Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Setup homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew}:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true; 

      environment.systemPackages =
        [ 
          pkgs.mkalias
          pkgs.neovim
          pkgs.tmux
          pkgs.gnupg
          pkgs.maccy
          pkgs.ripgrep
          pkgs.zoxide
          pkgs.hugo
          pkgs.htop
          pkgs.go
          pkgs.fzf
          pkgs.fd
          pkgs.bat
          pkgs.eza
          pkgs.neofetch
          pkgs.yt-dlp
          pkgs.podman
          pkgs.podman-compose
          pkgs.podman-tui
          pkgs.android-tools
          pkgs.nodejs
          pkgs.shadowsocks-rust
          pkgs.shadowsocks-libev
        ];

      homebrew = {
        enable = true;
        casks = [
          "eloston-chromium"
          "librewolf"
          "rectangle"
          "openmtp"
          "anki"
          "podman-desktop"
          "ghostty"
        ];
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
# Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
            '';

      # macos system settings
      system.defaults = {
        dock.autohide = true;
        dock.orientation = "right";
        dock.persistent-apps = [
          "/Applications/LibreWolf.app"
          "/Applications/Thunderbird.app"
          "/Applications/Chromium.app"
          "/Applications/Ghostty.app"
          "/Applications/Zed.app"
        ];
        dock.tilesize = 48;
        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;
        finder.FXPreferredViewStyle = "Nlsv";
        finder._FXSortFoldersFirst = true;
        finder.FXDefaultSearchScope = "SCcf";
        trackpad.Clicking = true;
        NSGlobalDomain.ApplePressAndHoldEnabled = false;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
        NSGlobalDomain."com.apple.keyboard.fnState" = true;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
        loginwindow.GuestEnabled = false;
        loginwindow.LoginwindowText = "Pratik's MacBook";
        loginwindow.SHOWFULLNAME = true;
        loginwindow.ShutDownDisabledWhileLoggedIn = true;
        screensaver.askForPassword = true;
        screensaver.askForPasswordDelay = 0;
        alf.globalstate = 1;
        alf.stealthenabled = 1;
        screencapture.location = "~/Downloads/screencapture";
      };

      # Auto upgrade nix package and the daemon service.
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."m3max" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "pratikgajjar";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
