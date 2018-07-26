dotfiles:
  - dir: /Users/shcrai
    files:
      - name: .bash_profile
      - name: .git-completion.sh
      - name: .git-prompt.sh
      - name: .gitconfig
      - name: .gitignore_global
      - {name: .pypirc, mode: '0600', type: secret}
      - name: .pylintrc
      - name: .shell_prompt.sh
      - name: .tmux.conf
      - name: .tmuxlinesnap
      - name: .vim
      - name: .vimrc
  - dir: /Users/shcrai/.pip
    files:
      - name: pip.conf
  - dir: /usr/local/share/luggage
    files:
      - {name: luggage.local, owner: root, group: wheel, limit_to_platform: MacOS}
  - dir: /Users/shcrai/.ssh
    files:
      - name: config
      - {name: id_rsa, mode: '0600', type: secret}
      - {name: id_rsa.pub, mode: '0640', type: secret}