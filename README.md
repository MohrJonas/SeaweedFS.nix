# SeaweedFS.nix - Declarative seaweedFS configuration

### DISCLAIMER: This is still in its early stages, and only the features I need have been implemented. If you need anything else, either create a pull request (PR) or an issue.

# Usage

```nix
{
  inputs = {
    seaweedfs.url = "github:mohrjonas/seaweedfs.nix";
  };
  outputs = { seaweedfs, ... }: {
    nixosConfigurations.<something> = nixpkgs.lib.nixosSystem {
      modules = [
        seaweedfs.nixosModules.seaweedfs
      ];
    };
  };
}
```

Sample:

```nix
    services.seaweedfs = {
      config = {
        "filer.toml" = filerConfig;
      };
      master = {
        enable = true;
        mdir = "/tmp/mdir";
        peers = [
          "127.0.0.1:9333"
        ];
        ip = "127.0.0.1";
      };
      filer = {
        enable = true;
        ip = "127.0.0.1";
        master = [
          "127.0.0.1:9333"
        ];
        dataCenter = "dc1";
        rack = "rc1";
      };
      volume = {
        enable = true;
        mserver = [
          "127.0.0.1:9333"
        ];
        dataCenter = "dc1";
        rack = "rc1";
        dir = [
          "/tmp/dir"
        ];
        ip = "127.0.0.1";
        max = "0";
      };
    };
```