ntp:
  pkg.latest:
    - pkgs:
      - ntp
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp
