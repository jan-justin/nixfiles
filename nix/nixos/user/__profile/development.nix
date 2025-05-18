{ ... }@_haumeaArgs:
{ config, lib, pkgs, ... }@_hmModuleArgs: {
  programs.bat.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config.hide_env_diff = true;
  programs.direnv.config.whitelist.prefix =
    [ config.xdg.configHome "${config.home.homeDirectory}/projects" ];

  programs.eza.enable = true;

  programs.git.enable = true;
  programs.git.difftastic.enable = true;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = true;
  };
  programs.git.signing = {
    format = "ssh";
    signByDefault = true;
    signer = "${pkgs._1password-gui}/bin/op-ssh-sign";
  };
  programs.git.userEmail = lib.mkDefault "jan.justin.vtonder@gmail.com";
  programs.git.userName = "Jan-Justin van Tonder";

  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  programs.helix.languages.language = [
    {
      name = "nix";
      auto-format = true;
      formatter.command = "nixpkgs-fmt";
    }
  ];
  programs.helix.settings = {
    editor = {
      color-modes = true;
      completion-trigger-len = 1;
      cursorline = true;
      end-of-line-diagnostics = "hint";
      line-number = "relative";
      true-color = true;
      undercurl = true;
    };
    editor.cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
    editor.file-picker = {
      hidden = false;
    };
    editor.inline-diagnostics = {
      cursor-line = "hint";
    };
    editor.lsp = {
      display-inlay-hints = true;
      display-messages = true;
    };
    keys.normal = { X = "extend_line_above"; };
    keys.select = { X = "extend_line_above"; };
    keys.normal.space."A-d" = {
      "c" = ":toggle inline-diagnostics-cursor-line hint disable";
      "e" = ":toggle end-of-line-diagnostics hint disable";
    };
    theme = "kanagawa";
  };
  programs.helix.themes = { empty = { }; };

  programs.jujutsu.enable = true;

  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host *
      IdentityAgent ~/.1password/agent.sock 
  '';

  programs.starship.enable = true;

  programs.zoxide.enable = true;
  programs.zoxide.options = [ "--cmd" "cd" ];

  xdg.userDirs.extraConfig.XDG_PROJECTS_DIR = "$HOME/projects";
}
