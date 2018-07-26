Init included submodules:
  module.run:
    - git.submodule:
      - cwd: {{ pillar['home'] }}/Developer/dotfiles
      - command: update
      - opts: --init --recursive
      - user: {{ pillar['user'] }}
