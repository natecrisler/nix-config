{ inputs, ... }: {
  imports = [ ./global ];
  colorscheme = inputs.nix-colors.colorSchemes.silk-dark;
}
