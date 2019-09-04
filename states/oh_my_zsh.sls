Install oh-my-zsh:
  cmd.script:
    - source: https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    - args: --unattended
    - shell: /bin/sh
    - runas: {{ pillar['user'] }}
    - creates: {{ pillar['home'] }}/.oh-my-zsh

chsh to zsh:
  cmd.run:
    - name: chsh -s $(which zsh) {{ pillar['user'] }}
    - onchanges:
      - cmd: Install oh-my-zsh