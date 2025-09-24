# Nix module for power management features on the ProBook.
{
  imports = [
    ./ryzenadj.nix
    ./tlp.nix
  ];

  # Add shell aliases to be able to switch between AC and battery profiles.
  environment.shellAliases = {
    ac = "ryzenadj-ac; sudo tlp ac";
    bat = "ryzenadj-bat; sudo tlp bat";
  };
}