{ lib }:
{
  scanPaths =
    path:
    builtins.map (name: path + "/${name}") (
      builtins.attrNames (
        lib.filterAttrs (
          name: type:
          (type == "directory" && builtins.pathExists (path + "/${name}/default.nix"))
          || (name != "default.nix" && lib.hasSuffix ".nix" name)
        ) (builtins.readDir path)
      )
    );
}
