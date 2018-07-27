Install yum packages:
  pkg.latest:
    - pkgs: {{ pillar['yum_packages'] }}
    - refresh: True