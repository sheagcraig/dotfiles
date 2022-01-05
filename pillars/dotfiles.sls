dotfiles:
  - dir: "~"
    files:
      - name: .gitconfig
      - name: .gitignore_global
      - {name: .pypirc, mode: '0600', type: secret}
      - name: .pylintrc
      - name: .tmux.conf
      - name: .tmuxlinesnap
      - name: .vim
      - name: .vimrc
      - name: .zshrc
  - dir: "~/.pip"
    files:
      - name: pip.conf
  - dir: /usr/local/share/luggage
    files:
      - {name: luggage.local, owner: root, group: wheel, limit_to_platform: MacOS}
  - dir: "~/.ssh"
    files:
      - name: config
      - {name: id_rsa, mode: '0600', type: secret}
      - {name: id_rsa.pub, mode: '0640', type: secret}
      - {name: id_ed25519, mode: '0600', type: secret}
      - {name: id_ed25519-cert.pub, mode: '0640', type: secret}
  - dir: "~/.gnupg"
    files:
      - {name: gpg-agent.conf, type: templated}
