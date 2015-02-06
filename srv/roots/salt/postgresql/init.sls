{% from "postgresql/map.jinja" import postgresql with context %}
/etc/yum.repos.d/CentOS-Base.repo:
  file.managed:
    - source: salt://postgresql/files/etc/yum.repos.d/CentOS-Base.repo
    - user: root
    - group: root
    - mode: 644
    - backup: minion
/etc/yum.repos.d/pgdg-{{postgresql.version_short}}-centos.repo:
  file.managed:
    - source: salt://postgresql/files/etc/yum.repos.d/pgdg-{{postgresql.version_short}}-centos.repo
    - user: root
    - group: root
    - mode: 644

/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-{{postgresql.version_short}}:
  file.managed:
    - source: salt://postgresql/files/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-{{postgresql.version_short}}
    - user: root
    - group: root
    - mode: 644
    - backup: minion
