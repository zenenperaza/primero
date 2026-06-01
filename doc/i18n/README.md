# Revisión de traducciones en español

La auditoría se ejecutó nuevamente el 2 de junio de 2026 con:

```sh
bin/bundle exec i18n-tasks missing es --format keys
```

El reporte reproducible está en `es-missing-keys.txt`. Ya no contiene claves
pendientes. Las 332 traducciones detectadas en la auditoría inicial se
completaron en `config/locales/completions/es.yml`.

El archivo complementario mantiene las traducciones nuevas separadas del
catálogo histórico `config/locales/es.yml`. Rails carga ambos archivos y
`config/i18n-tasks.yml` incluye los dos orígenes en la auditoría.
