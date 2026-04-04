{
  description = "NixOS system setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations.nv-nix = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
      };
    };
}
