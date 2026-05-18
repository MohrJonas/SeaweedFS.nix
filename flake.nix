{
  description = "SeaweedFS configuration module";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosModules.seaweedfs = ./seaweedfs.nix;
  };
}
