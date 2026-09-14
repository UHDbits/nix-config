{ lib }:
{
  scanPaths =
    path:
    builtins.map (name: path + "/${name}") (
      builtins.attrNames (
        lib.filterAttrs (
          name: type: type == "directory" || (name != "default.nix" && lib.hasSuffix ".nix" name)
        ) (builtins.readDir path)
      )
    );
}
