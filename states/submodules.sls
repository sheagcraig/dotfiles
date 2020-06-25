Init included submodules:
  module.run:
    - git.submodule:
      - cwd: {{ pillar['home'] }}/Developer/dotfiles
      - command: update
      - opts: --init --recursive
      - user: {{ pillar['user'] }}
    - creates: {{ opts['file_roots']['base'][0] }}/files/fonts/install.sh

Install fonts:
  cmd.run:
    - name: {{ opts['file_roots']['base'][0] }}/files/fonts/install.sh
    - runas: {{ pillar['user'] }}
    - onchanges:
      - module: Init included submodules
