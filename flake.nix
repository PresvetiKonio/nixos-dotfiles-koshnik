{
  description = "NixOS on the koshnik";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #lazyvim.url = "github:pfassina/lazyvim-nix";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    apollo-flake = {
      url = "github:nil-andreas/apollo-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      lazyvim,
      apollo-flake,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.koshnik = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vladko = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit lazyvim; };
            };
          }
          # Apollo
          apollo-flake.nixosModules.x86_64-linux.default
          ({ pkgs, ... }: {
            services.apollo.package = apollo-flake.packages.${pkgs.system}.default;
          })
        ];
      };
    };
}
