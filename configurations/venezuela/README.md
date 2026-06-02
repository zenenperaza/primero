# Configuración local de Venezuela

Esta configuración amplía los seeds CP incluidos en Primero v2:

- habilita las Solicitudes de Localización (`tracing_request`);
- carga Venezuela, 24 entidades con municipios y 335 municipios;
- configura el nivel de reporte por estado;
- crea la agencia operativa `ASONACOP` con código corto `LRF`;
- crea los roles `Monitor LRF` y `Coordinador LRF`;
- usa el grupo general `LRF Nacional` y crea un grupo territorial por estado;
- crea los usuarios iniciales `primero_ftr` y `primero_mgr_ftr`;
- carga traducciones españolas para los formularios y catálogos de Casos;
- amplía Solicitudes de Localización con admisión, personas vinculadas,
  cuidado y reunificación, alertas, consentimientos, actuaciones, apoyos
  entregados y documentos restringidos.

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

## Flujo de Solicitudes de Localización

Los formularios adicionales están definidos en
`ftr_solicitudes_localizacion.rb`. La Solicitud de Localización se utiliza como
puerta de entrada para admisión, búsqueda, consentimientos y reunificación. Si
se identifican alertas de protección o atención prolongada, se debe crear o
vincular un Caso para gestionar servicios, derivaciones y seguimientos.

El archivo `ftr_solicitudes_localizacion_blueprint.md` documenta el mapeo
funcional anonimizado utilizado para adaptar los formularios físicos.

## Agencia, roles y grupos territoriales

Los monitores deben usar el rol `Monitor LRF`, la agencia `ASONACOP` y el grupo
territorial correspondiente, por ejemplo `LRF - Táchira`. Este rol gestiona
solamente sus propias solicitudes.

Los coordinadores deben usar el rol `Coordinador LRF`, la agencia `ASONACOP` y
uno o varios grupos territoriales. Este rol permite supervisar las solicitudes
de los grupos asignados. El grupo `LRF Nacional` queda disponible para cuentas
con cobertura general.

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
