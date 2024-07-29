{
  description = "System flake (electric boogaloo)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations.RyoYamada = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix 
        stylix.nixosModules.stylix
      ];
    };

    homeConfigurations = {
      "aletschfirn" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          ./home.nix
          stylix.homeManagerModules.stylix
        ]; 
      };
    };
  };
}
