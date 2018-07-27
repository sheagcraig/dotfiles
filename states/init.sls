include:
  - .dotfiles
  - .submodules
  {% if grains['os'] == 'MacOS' %}
  - .homebrew
  - .defaults
  - .dock
  {% elif grains['os_family'] == 'RedHat' %}
  - .yum
  {% endif %}
