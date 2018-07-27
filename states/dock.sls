Autohide Dock:
  macdefaults.write:
    - name: autohide
    - domain: com.apple.dock
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

Set dock icon sizes smaller:
  macdefaults.write:
    - name: tilesize
    - domain: com.apple.dock
    - vtype: integer
    - value: 36
    - user: {{ pillar['user'] }}

{% for item in pillar['dock_removals'] %}
Remove unwanted items from dock - {{ item }}:
  cmd.run:
    - name: dockutil --remove {{ item }}
    - onlyif: dockutil --find {{ item }}
    - runas: {{ pillar['user'] }}
    - onchanges_in:
      - cmd: Restart dock
{% endfor %}

Restart dock:
  cmd.run:
    - name: killall Dock
    - runas: {{ pillar['user'] }}
    - onchanges_any:
      - macdefaults: Autohide Dock
      - macdefaults: Set dock icon sizes smaller
