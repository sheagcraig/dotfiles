Init included submodules:
  module.run:
    - name: git.submodule
    - cwd: {{ pillar['home'] }}/Developer/dotfiles
    - command: update
    - opts: --init --recursive
    - user: {{ pillar['user'] }}
