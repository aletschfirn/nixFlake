{ pkgs, ...}: {
  # System-wide packages (only use what is not in home-manager)
  environment.systemPackages = with pkgs; [
    doas-sudo-shim
    neofetch
  ];
}