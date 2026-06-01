# Configuración local de Venezuela

Esta configuración amplía los seeds CP incluidos en Primero v2:

- habilita las Solicitudes de Localización (`tracing_request`);
- carga Venezuela, 24 entidades con municipios y 335 municipios;
- configura el nivel de reporte por estado;
- crea los roles `FTR Worker` y `FTR Manager`;
- usa el grupo `Primero FTR`;
- crea los usuarios iniciales `primero_ftr` y `primero_mgr_ftr`;
- carga traducciones españolas para los formularios y catálogos de Casos.

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
