include:
  - .dotfiles
  - .submodules
  - .npm
  {% if grains['os'] == 'MacOS' %}
  - .homebrew
  - .defaults
  - .dock
  - .terms
  {% elif grains['os_family'] == 'RedHat' %}
  - .yum
  {% endif %}
