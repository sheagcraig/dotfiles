Put Jabra launchagent in place:
  file.managed:
    - source: {{ opts['file_roots']['base'][0] }}/files/com.sheagcraig.jabravolume.plist
    - name: {{ pillar['home'] }}/Library/LaunchAgents/com.sheagcraig.jabravolume.plist

Put Jabra script in place:
  file.managed:
    - source: {{ opts['file_roots']['base'][0] }}/files/jabravolume.sh
    - name: /usr/local/bin/jabravolume.sh
    - mode: 0755

