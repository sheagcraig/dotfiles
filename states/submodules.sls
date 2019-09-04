Init included submodules:
  module.run:
    - git.submodule:
      - cwd: {{ pillar['home'] }}/Developer/dotfiles
      - command: update
      - opts: --init --recursive
      - user: {{ pillar['user'] }}

Install fonts:
  cmd.run:
    - name: {{ opts['file_roots']['base'][0] }}/files/fonts/install.sh
    - runas: {{ pillar['user'] }}
    - creates:
      - {{ pillar['home'] }}/Library/Fonts/Hack-Regular.ttf
    # TODO: Above state always fails; so we're doing it manually for now.
    # - require:
    #   - module: Init included submodules
