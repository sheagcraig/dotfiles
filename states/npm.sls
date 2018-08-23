Install npm packages:
  npm.installed:
    - pkgs: {{ pillar['npm_installed_packages'] }}
    - user: {{ pillar['user'] }}
