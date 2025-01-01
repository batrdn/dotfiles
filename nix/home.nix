{ config, pkgs, ... }:

{
  home.username = "batrdn";
  home.homeDirectory = "/home/batrdn";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.neovim
    pkgs.zsh
    pkgs.starship
    pkgs.delta
    pkgs.alacritty
    pkgs.tmux
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.fzf
    pkgs.zoxide
    pkgs.bat
    pkgs.eza
    pkgs.fd
    pkgs.dust
    pkgs.btop
    pkgs.tlrc
    pkgs.jq
    pkgs.yq
    pkgs.ripgrep
    pkgs.neofetch
    pkgs.obsidian
    pkgs.slides
    pkgs.rustup
    pkgs.fnm
    pkgs.deno
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
  ];

  home.file = {
    ".zshrc".source = ~/dotfiles/zsh/.zshrc;
    ".gitconfig".source = ~/dotfiles/git/.gitconfig;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/alacritty".source = ~/dotfiles/alacritty;
    ".config/bat".source = ~/dotfiles/bat;
    ".config/delta".source = ~/dotfiles/delta;
    ".config/lazygit".source = ~/dotfiles/lazygit;
    ".config/lazydocker".source = ~/dotfiles/lazydocker;
    ".config/starship".source = ~/dotfiles/starship;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    TERM = "alacritty";
  };

  programs.zsh = {
    enable = true;
  };

  programs.home-manager.enable = true;
}
