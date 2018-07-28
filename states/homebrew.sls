Install homebrew packages:
  pkg.installed:
    - pkgs: {{ pillar['homebrew_installed_packages'] }}
    - refresh: True
    # I'd like to use pkg.latest, but it doesn't work right.

Update packages:
  cmd.run:
    - name: brew upgrade
    - runas: {{ pillar['user'] }}
    - require:
        - pkg: Install homebrew packages