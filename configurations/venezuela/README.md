# Configuración local de Venezuela

Esta configuración amplía los seeds CP incluidos en Primero v2:

- habilita las Solicitudes de Localización (`tracing_request`);
- carga Venezuela, 24 entidades con municipios y 335 municipios;
- configura el nivel de reporte por estado;
- crea la agencia operativa `ASONACOP` con código corto `LRF`;
- crea los roles `Administrador LRF`, `Monitor LRF`,
  `Coordinador Regional LRF`, `Coordinador Terreno LRF` y `Gerente LRF`;
- usa el grupo general `LRF Nacional` y crea los grupos territoriales
  `LRF - Táchira` y `LRF - Zulia`;
- crea los usuarios iniciales `primero_ftr` y `primero_mgr_ftr`;
- carga traducciones españolas para los formularios y catálogos de Casos;
- deja respaldados, pero no cargados automáticamente, los formularios LRF de
  Solicitudes de Localización.

La carga reemplaza todas las ubicaciones existentes. Antes de ejecutarla, crear
un respaldo de PostgreSQL y agregar explícitamente las siguientes variables
privadas a `docker/local.env`, que está ignorado por Git:

```dotenv
PRIMERO_VENEZUELA_REPLACE_LOCATIONS=true
PRIMERO_FTR_WORKER_EMAIL=correo-real-del-trabajador
PRIMERO_FTR_WORKER_PASSWORD=contraseña-segura
PRIMERO_FTR_MANAGER_EMAIL=correo-real-del-gerente
PRIMERO_FTR_MANAGER_PASSWORD=contraseña-segura
```

Las credenciales se usan solamente al crear las cuentas. Las ejecuciones
posteriores no reemplazan las contraseñas existentes.

## TLS local confiable

Para generar un certificado confiable para `localhost`, `127.0.0.1` y `::1`
con `mkcert`, ejecutar:

```powershell
.\tools\setup_local_tls.ps1
```

Los certificados se guardan en `docker/certs/local`, que está ignorado por
Git. El override local de Docker monta ese directorio en Nginx.

## Traducciones de Casos

Las traducciones de formularios y catálogos almacenados en base de datos están
en `translations_es.rb`. El cargador venezolano las aplica después de los seeds
estándar de Primero. Esto cubre secciones, campos visibles y listas utilizadas
por Casos.

## Formularios LRF archivados

Los formularios adicionales están respaldados en
`ftr_solicitudes_localizacion.rb`, pero no se cargan automáticamente desde
`load_configuration.rb`. También existe un respaldo JSON de la base en
`backups/ftr_solicitudes_localizacion_forms_20260604.json`.

Cuando se decida instalar de nuevo ese flujo, se puede volver a cargar
`ftr_solicitudes_localizacion.rb` para restaurar admisión, personas vinculadas,
cuidado/reunificación, alertas, consentimientos, actuaciones, apoyos y
documentos.

Si una instancia ya tiene esos formularios cargados y se quiere volver al flujo
estándar, ejecutar `remove_lrf_tracing_request_forms.rb` desde Rails.

El archivo `ftr_solicitudes_localizacion_blueprint.md` documenta el mapeo
funcional anonimizado utilizado para adaptar los formularios físicos.

## Agencia, roles y grupos territoriales

Todos los usuarios LRF deben usar la agencia `ASONACOP`.

Roles nacionales:

- `Administrador LRF`: administra usuarios, roles, grupos y todas las
  Solicitudes de Localización a nivel nacional.
- `Monitor LRF`: monitorea y gestiona todas las Solicitudes de Localización a
  nivel nacional, sin administrar usuarios ni roles.
- `Gerente LRF`: consulta, audita y exporta todas las Solicitudes de
  Localización a nivel nacional. También recibe permisos de aprobación sobre
  Casos vinculados, ya que Primero no tiene aprobación nativa para
  `tracing_request`.

Roles territoriales:

- `Coordinador Regional LRF`: gestiona las Solicitudes de Localización de los
  grupos territoriales asignados.
- `Coordinador Terreno LRF`: registra y gestiona las Solicitudes de
  Localización del grupo territorial asignado.

Para un estado, ambos roles territoriales deben compartir el mismo grupo. Por
ejemplo, para Zulia se asigna `LRF - Zulia` tanto al `Coordinador Regional LRF`
como al `Coordinador Terreno LRF`. Para Táchira se usa `LRF - Táchira`. El grupo
`LRF Nacional` queda disponible para cuentas con cobertura general.

Los códigos de ubicación usan el formato jerárquico `VE`, `VE01` y `VE0101`.
Para el flujo operativo inicial, `VE01` corresponde a Táchira y `VE02` a Zulia.

## Datos geográficos

El CSV HXL se genera con:

```powershell
.\tools\generate_venezuela_locations.ps1
```

La fuente base es
[`zokeber/venezuela-json`](https://github.com/zokeber/venezuela-json), que
publica los 335 municipios. El generador aplica el nombre actual `La Guaira`
al estado anteriormente denominado `Vargas` y asigna códigos internos estables
compatibles con `ltree`.

`Dependencias Federales` no se carga porque no tiene municipios. La carga
operativa tampoco agrega `Guayana Esequiba`: la Gaceta Oficial N.° 6.798
Extraordinario del 3 de abril de 2024 crea ese estado, pero esta configuración
no dispone de una jerarquía municipal operativa validada para incorporarlo.

## Actualización del VPS

Después de respaldar PostgreSQL y actualizar el código desde GitHub, reconstruir
las imágenes modificadas desde el directorio `docker`:

```sh
./build.sh application -t latest
./build.sh nginx -t latest
./compose.prod.sh up -d --force-recreate application worker nginx
```

Para aplicar la configuración de Venezuela por primera vez, definir las
variables privadas indicadas anteriormente y ejecutar:

```sh
./compose.configure.sh ../configurations/venezuela
```

No ejecutar el cargador sobre una instancia con datos operativos sin revisar
antes el impacto de reemplazar ubicaciones y de reaplicar la configuración
estándar de Primero.
