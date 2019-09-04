include:
  - .dotfiles
  - .submodules
  - .npm
  - .oh_my_zsh
  {% if grains['os'] == 'MacOS' %}
  - .homebrew
  - .defaults
  - .dock
  - .terms
  {% elif grains['os_family'] == 'RedHat' %}
  - .yum
  {% endif %}
