include:
  - .oh_my_zsh
  - .dotfiles
  - .submodules
  # - .npm
  {% if grains['os'] == 'MacOS' %}
  - .defaults
  - .dock
  - .terms
  - .jabra
  {% elif grains['os_family'] == 'RedHat' %}
  - .yum
  {% endif %}
