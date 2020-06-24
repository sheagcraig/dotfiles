dotfiles:
  - dir: /Users/shea
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
  - dir: /Users/shea/.pip
    files:
      - name: pip.conf
  - dir: /usr/local/share/luggage
    files:
      - {name: luggage.local, owner: root, group: wheel, limit_to_platform: MacOS}
  - dir: /Users/shea/.ssh
    files:
      - name: config
      - {name: id_rsa, mode: '0600', type: secret}
      - {name: id_rsa.pub, mode: '0640', type: secret}
