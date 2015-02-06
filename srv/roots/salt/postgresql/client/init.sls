{% from "postgresql/map.jinja" import postgresql with context %}
include:
  - postgresql

postgresql{{postgresql.version_short}}:
  pkg.installed
