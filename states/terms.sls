#include:
#  - .homebrew

Setup iTerm prefs location:
  macdefaults.write:
    - name: PrefsCustomFolder
    - domain: com.googlecode.iterm2.plist
    - value: {{ opts['file_roots']['base'][0] }}/files/
    - user: {{ pillar['user'] }}
    #- require:
    #  - pkg: Install homebrew packages

Direct iTerm to use custom prefs location:
  macdefaults.write:
    - name: LoadPrefsFromCustomFolder
    - domain: com.googlecode.iterm2.plist
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}
    #- require:
    #  - pkg: Install homebrew packages
