npm:
  pkg.installed:
    - refresh: True
    # I'd like to use pkg.latest, but it doesn't work right.

Install npm packages:
  npm.installed:
    - pkgs: {{ pillar['npm_installed_packages'] }}
    - user: {{ pillar['user'] }}
    - require:
        - pkg: npm
