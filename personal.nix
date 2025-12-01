{
  # Seus aliases
  environment.shellAliases = {
    clean = "sudo nix-collect-garbage -d";
    cls = "sudo nix-collect-garbage -d && sudo nix store optimise && sudo nixos-rebuild switch --upgrade";
    up2 = "sudo nixos-rebuild switch --upgrade";
    update = "sudo nixos-rebuild switch --upgrade";
    up = "sudo nixos-rebuild switch";
    rebuild = "sudo nixos-rebuild switch";
    al = "sudo nvim /etc/nixos/personal.nix";
    v = "nvim";
    nv = "nvim";
    ft = "fastfetch --logo small";
    enix = "sudo nvim /etc/nixos/configuration.nix";
    edit = "sudo nvim /etc/nixos/configuration.nix";
    duf = "duf -hide special";
    df = "duf -hide special";
    hg = "history | grep";
    ag = "alias | grep";
    ls = "eza -lah --color=always --group-directories-first --icons";
    ll = "eza -lah --color=always --group-directories-first --icons";
    grep = "grep -i";
    cp = "cp -i";
    mv = "mv -i";
    mkdir = "mkdir -p";
  };

  # 2. Adiciona o comando de inicialização ao ~/.bashrc de cada usuário
  # programs.bash.interactiveShellInit = ''
  #   if command -v starship &> /dev/null; then
  #     eval "$(starship init bash)"
  #   fi
  # '';

  environment.interactiveShellInit = ''
    # Expand the history size
    export HISTFILESIZE=10000
    export HISTSIZE=500
    export HISTTIMEFORMAT="%F %T" # add timestamp to history

    # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
    shopt -s checkwinsize

    # Don't put duplicate lines in the history and do not add lines that start with a space
    export HISTCONTROL=erasedups:ignoredups:ignorespace

    # Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
    shopt -s histappend
    PROMPT_COMMAND='history -a'

    
    if command -v starship &> /dev/null; then
       eval "$(starship init bash)"
    fi

  '';
}
