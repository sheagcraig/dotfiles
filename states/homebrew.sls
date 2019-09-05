Install homebrew packages:
  pkg.installed:
    - pkgs: {{ pillar['homebrew_installed_packages'] }}
    - refresh: True
    # I'd like to use pkg.latest, but it doesn't work right.

Update packages:
  cmd.run:
    - name: /usr/local/bin/brew upgrade
    - runas: {{ pillar['user'] }}
    - require:
        - pkg: Install homebrew packages

Update cask packages:
  cmd.run:
    - name: /usr/local/bin/brew cask upgrade
    - runas: {{ pillar['user'] }}
    - require:
        - pkg: Install homebrew packages