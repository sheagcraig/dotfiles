Use column view for all Finder windows:
  macdefaults.write:
    - name: FXPreferredViewStyle
    - domain: com.apple.Finder
    - value: clmv
    - user: {{ pillar['user'] }}

Allow text selection in Quicklook:
  macdefaults.write:
    - name: QLEnableTextSelection
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

{% for key in ('ShowHardDrivesOnDesktop', 'ShowExternalHardDrivesOnDesktop', 'ShowMountedServersOnDesktop', 'ShowRemovableMediaOnDesktop') %}
Show different devices on the Desktop - {{ key }}:
  macdefaults.write:
    - name: {{ key }}
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}
{% endfor %}

Show normally hidden things in Finder...:
  macdefaults.write:
    - name: AppleShowAllExtensions
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

Show normally hidden things in Finder 2:
  macdefaults.write:
    - name: _FXShowPosixPathInTitle
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

Disable prompt when changing file extension:
  macdefaults.write:
    - name: FXEnableExtensionChangeWarning
    - domain: com.apple.Finder
    - vtype: bool
    - value: False
    - user: {{ pillar['user'] }}

Don't spray .DS_Store all over usb volumes:
  macdefaults.write:
    - name: DSDontWriteUSBStores
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

Don't spray .DS_Store all over network volumes:
  macdefaults.write:
    - name: DSDontWriteNetworkStores
    - domain: com.apple.Finder
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

{% for key in ('IncludeDevelopMenu', 'WebKitDeveloperExtrasEnabledPreferenceKey', 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled') %}
Enable Safari develop menu - {{ key }}:
  macdefaults.write:
    - name: {{ key }}
    - domain: com.apple.Safari
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}
{% endfor %}

Enable develop menu contextual item for all WebViews:
  macdefaults.write:
    - name: WebKitDeveloperExtras
    - domain: NSGlobalDomain
    - vtype: bool
    - value: True
    - user: {{ pillar['user'] }}

Set orange highlight color:
  macdefaults.write:
    - name: AppleHighlightColor
    - domain: NSGlobalDomain
    - vtype: string
    - value: 1.000000 0.874510 0.701961
    - user: {{ pillar['user'] }}

# Doesn't seem to actually work consistently; maybe Mojave...
# This doesn't actually change the menu bar theme until you sign out.
Set dark theme:
  macdefaults.write:
    - name: AppleInterfaceStyle
    - domain: NSGlobalDomain
    - value: Dark
    - user: {{ pillar['user'] }}

Disable auto-correct:
  macdefaults.write:
    - name: NSAutomaticSpellingCorrectionEnabled
    - domain: NSGlobalDomain
    - vtype: bool
    - value: False
    - user: {{ pillar['user'] }}

Enable nameboard to tab between modal views:
  macdefaults.write:
    - name: AppleKeyboardUIMode
    - domain: NSGlobalDomain
    - vtype: int
    - value: 3
    - user: {{ pillar['user'] }}

Restart Finder:
  cmd.run:
    - name: killall Finder
    - user: {{ pillar['user'] }}
    - onchanges:
      - macdefaults: Use column view for all Finder windows
      - macdefaults: Set orange highlight color

Restart SystemUIServer:
  cmd.run:
    - name: killall SystemUIServer
    - user: {{ pillar['user'] }}
    - onchanges:
      - macdefaults: Set dark theme

Restart Dock:
  cmd.run:
    - name: killall Dock
    - user: {{ pillar['user'] }}
    - onchanges:
      - macdefaults: Set dark theme
