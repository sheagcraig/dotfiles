{% for location in pillar['dotfiles'] %}
{% for file in location['files'] %}
{% if 'limit_to_platform' not in file or file['limit_to_platform'] == grains['os'] %}
{% if file.get('type', 'link') == 'secret' %}
Copy secret {{ pillar['secrets_dir'] }} {{ file['name'] }} dotfile:
  file.managed:
    - source: {{ pillar['secrets_dir'] }}/{{ file['name'] }}
    - name: {{ location['dir'] | replace('~', pillar['home']) }}/{{ file['name'] }}
{% elif file.get('type', 'link') == 'templated' %}
Copy templated {{ pillar['secrets_dir'] }} {{ file['name'] }} dotfile:
  file.managed:
    - source: {{ opts['file_roots']['base'][0] }}/files/{{ file['name'] }}
    - name: {{ location['dir'] | replace('~', pillar['home']) }}/{{ file['name'] }}
    - template: jinja
{% else %}
Link {{ file['name'] }} dotfile:
  file.symlink:
    - target: {{ opts['file_roots']['base'][0] }}/files/{{ file['name'] }}
    - name: {{ location['dir'] | replace('~', pillar['home']) }}/{{ file['name'] }}
{% endif %}
    - user: {{ file.get('owner', pillar['user']) }}
    - group : {{ file.get('group', 'staff') }}
    - mode: {{ file.get('mode', '0700') }}
    - force: True
    - makedirs: True
    {% endif %}
  {% endfor %}
{% endfor %}
