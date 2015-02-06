{% from "postgresql/map.jinja" import postgresql with context %}
include:
  - postgresql

postgresql-server:
  pkg.latest:
    - pkgs:
      - postgresql{{postgresql.version_short}}-server
      - postgresql{{postgresql.version_short}}-libs
      - postgresql{{postgresql.version_short}}-devel
      - postgresql{{postgresql.version_short}}
    - require:
      - sls: postgresql
  service.running:
    - name: postgresql-{{postgresql.version}}
    - enable: true
    - require:
      - pkg: postgresql-server
      - cmd: postgresql-server
      - file: /var/lib/pgsql/{{postgresql.version}}/data/pg_hba.conf
      - file: /var/lib/pgsql/{{postgresql.version}}/data/postgresql.conf
  cmd.run:
    - cwd: /
    - user: root
    - name: service postgresql-{{postgresql.version}} initdb
    - unless: stat /var/lib/pgsql/{{postgresql.version}}/data/postgresql.conf
    - require:
      - pkg: postgresql-server

{% for file in ['pg_hba.conf',
                'postgresql.conf'] %}
/var/lib/pgsql/{{postgresql.version}}/data/{{ file }}:
  file.managed:
    - source: salt://postgresql/files/var/lib/pgsql/data/{{ file }}
    - user: postgres
    - group: postgres
    - mode: 600
    - backup: minion
    - require:
      - cmd: postgresql-server
{% endfor %}
