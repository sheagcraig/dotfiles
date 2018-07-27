Install homebrew packages:
  pkg.installed:
    - pkgs: {{ pillar['homebrew_installed_packages'] }}
    - refresh: True

Install taps:
  cmd.run:
    - name: brew tap {{ pillar['homebrew_taps'] | join(' ') }}
    - runas: {{ pillar['user'] }}

Install casks:
  cmd.run:
    - name: brew cask install {{ pillar['homebrew_cask_apps'] | join(' ') }}
    - runas: {{ pillar['user'] }}
    - require:
        - cmd: Install taps

Update casks:
  cmd.run:
    - name: brew cask upgrade {{ pillar['homebrew_cask_apps'] | join(' ') }}
    - runas: {{ pillar['user'] }}
    - require:
        - cmd: Install casks