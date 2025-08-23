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
  programs.helix.package = pkgs.helix_git.overrideAttrs (prev:
    let
      rectifiedGrammarLinks = lib.attrsets.mapAttrsToList
        (lang: drv: "ln -s ${drv}/parser $out/lib/runtime/grammars/${lang}.so")
        prev.passthru.grammars;
    in
    {
      src = pkgs.fetchFromGitHub {
        owner = "helix-editor";
        repo = "helix";
        rev = "282345c4b80716ac3d98baf114b153969738b1da";
        sha256 = "sha256-mHvZ8eBuOAUt/JFfhJkBG51+qxEmp2dCnmsKwKVAEbk=";
      };

      postInstall = prev.postInstall + ''
        # Kanagawa gutter tweak
        substituteInPlace $out/lib/runtime/themes/kanagawa.toml --replace \
          '"ui.gutter" = { fg = "sumiInk6", bg = "sumiInk4" }' \
          '"ui.gutter" = { fg = "sumiInk6", bg = "sumiInk3" }'

        # Grammar fix
        rm $out/lib/runtime/grammars 
        mkdir -p $out/lib/runtime/grammars
      '' + (builtins.concatStringsSep "\n" rectifiedGrammarLinks);
    });
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
  programs.jujutsu.package = pkgs.jujutsu_git;
  programs.jujutsu.settings.user = {
    email = lib.mkDefault "jan.justin.vtonder@gmail.com";
    name = "Jan-Justin van Tonder";
  };
  programs.jujutsu.settings.signing = {
    backend = "ssh";
    backends.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    behavior = "own";
  };
  programs.jujutsu.settings.ui.pager = ":builtin";

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
