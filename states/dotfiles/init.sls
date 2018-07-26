{% for location in pillar['dotfiles'] %}
{% for file in location['files'] %}
{% if 'limit_to_platform' not in file or file['limit_to_platform'] == grains['os'] %}
{% if file.get('type', 'link') == 'secret' %}
Link {{ file['name'] }} dotfile:
  file.managed:
    - source: {{ pillar['secrets_dir'] }}/{{ file['name'] }}
{% else %}
Copy secret {{ file['name'] }} dotfile:
  file.symlink:
    - target: {{ opts['file_roots']['base'][0] }}/files/{{ file['name'] }}
{% endif %}
    - name: {{ location['dir'] | replace('~', pillar['home']) }}/{{ file['name'] }}
    - user: {{ file.get('owner', pillar['user']) }}
    - group : {{ file.get('group', 'staff') }}
    - mode: {{ file.get('mode') }}
    - force: True
    - makedirs: True
    {% endif %}
  {% endfor %}
{% endfor %}
