# Solicitudes de Localizacion: plano funcional

Este documento traduce un expediente fisico de ejemplo del programa de
localizacion y reunificacion familiar a una propuesta de formularios para
Primero v2. El plano es deliberadamente anonimo: no contiene nombres, codigos
de caso, documentos de identidad, telefonos, direcciones, firmas, huellas ni
fotografias del expediente fuente.

## Principios

- Capturar como campos estructurados solo la informacion que se necesita para
  buscar, asignar, dar seguimiento, filtrar o reportar.
- Usar subformularios para personas, contactos, actuaciones y entregas que
  pueden repetirse.
- Conservar consentimientos firmados, valoraciones profesionales, documentos de
  identidad, dibujos, constancias y fotografias como adjuntos controlados.
- Separar permisos por rol para reducir la exposicion de datos sensibles.
- Evitar duplicar en Solicitudes de Localizacion todos los campos que ya
  pertenecen al modulo de Casos.

## Alcance del expediente revisado

| Paginas del expediente | Contenido | Tratamiento propuesto |
| --- | --- | --- |
| 1-2 | Ingreso al programa, referencia, situacion actual, riesgo y servicios requeridos | Campos estructurados de admision |
| 3-6 | Consentimientos informados y autorizaciones de uso o intercambio de datos | Controles estructurados minimos y PDF firmado como adjunto |
| 7-9 | Informacion de personas vinculadas | Subformulario repetible de personas y contactos |
| 10-15 | Ficha de registro, cuidados, familia, alertas de proteccion y acciones inmediatas | Datos basicos FTR y evaluacion inicial resumida |
| 16-18 | Valoracion profesional y material producido durante la atencion | Adjunto restringido con fecha, tipo y resumen breve |
| 19 | Entrevista inicial de trabajo social | Adjunto restringido y resumen de intervencion |
| 20-21 | Constancias firmadas de entrega de apoyo | Subformulario repetible de apoyos y adjunto de constancia |
| 22-26 | Otros soportes, documentos de identidad y fotografias | Adjuntos restringidos clasificados |

## Formularios propuestos para Solicitudes de Localizacion

### 1. Admision y referencia

Campos estructurados:

- Fecha de referencia.
- Organizacion o institucion remitente.
- Pais, estado y municipio de referencia.
- Codigo externo del programa.
- Tipo de solicitud.
- Situacion actual y contexto.
- Nivel de riesgo: alto, medio o bajo.
- Servicios requeridos.
- Gestor responsable.

### 2. Persona buscada

Ampliar el formulario FTR estandar con:

- Nombres, apellidos y nombre conocido.
- Fecha de nacimiento y marca de fecha aproximada.
- Edad aproximada.
- Sexo.
- Nacionalidad.
- Documento de identidad: tipo y numero.
- Grupo demografico o condicion migratoria.
- Idioma y necesidades especiales de comunicacion.
- Pertenencia etnica, cuando corresponda.
- Ultima ubicacion conocida y telefono.
- Fecha, lugar y causa de separacion.

Los campos que ayudan a localizar coincidencias deben conservar la propiedad
`matchable`.

### 3. Solicitante y contacto principal

Reutilizar y traducir el formulario FTR estandar `Inquirer`, agregando:

- Tipo de relacion con la persona buscada.
- Documento de identidad: tipo y numero.
- Ubicacion actual.
- Medio de contacto preferido.
- Consentimiento para contactar.
- Consentimiento para compartir informacion con terceros autorizados.

### 4. Personas vinculadas

Crear un subformulario repetible:

- Tipo de persona: cuidador, familiar conviviente, familiar externo, contacto
  clave u otra persona importante.
- Nombres y apellidos.
- Relacion.
- Edad o fecha de nacimiento.
- Sexo.
- Nacionalidad.
- Documento de identidad: tipo y numero.
- Ubicacion y telefono.
- Convive actualmente con la persona buscada.
- Consentimiento para contactar.
- Observaciones.

### 5. Cuidado actual y reunificacion

Campos estructurados:

- Modalidad de cuidado actual.
- Nombre y relacion del cuidador principal.
- Fecha desde la cual ejerce el cuidado.
- Disposicion del cuidador para mantener el cuidado.
- Familia conocida y contactos disponibles.
- Opcion prevista para reunificacion o traslado.
- Ubicacion prevista.
- Observaciones de reunificacion.

### 6. Alertas y respuesta inmediata

Campos estructurados:

- Alertas de proteccion identificadas, como seleccion multiple.
- Dificultades funcionales identificadas, como seleccion multiple.
- Nivel de riesgo actualizado.
- Requiere respuesta inmediata.
- Areas de respuesta: salud, seguridad, cuidado temporal, documentacion,
  apoyo psicosocial, alimentos, alojamiento, transporte u otra.
- Accion o referencia aplicada.
- Observaciones.

Este formulario debe limitarse a una evaluacion inicial. La gestion detallada
de proteccion, derivaciones, servicios y seguimiento ya existe en el modulo de
Casos.

### 7. Consentimientos y autorizaciones

Campos estructurados:

- Consentimiento informado obtenido.
- Fecha del consentimiento.
- Tipo de firmante.
- Relacion del firmante.
- Autoriza contacto.
- Autoriza recoleccion y almacenamiento de informacion.
- Autoriza compartir informacion con prestadores de servicios.
- Autoriza uso de imagen, si aplica.
- Restricciones o excepciones.
- Asentimiento del NNA, cuando corresponda.
- Documento firmado, como `document_upload_box`.

### 8. Actuaciones de localizacion

Crear un subformulario repetible:

- Fecha.
- Tipo de actuacion.
- Organizacion o responsable.
- Ubicacion.
- Descripcion breve.
- Resultado.
- Proxima accion.

### 9. Apoyos entregados

Crear un subformulario repetible:

- Fecha de entrega.
- Tipo de apoyo.
- Descripcion.
- Cantidad.
- Organizacion responsable.
- Observaciones.
- Constancia firmada, como `document_upload_box`.

### 10. Documentos y soportes

Crear un formulario restringido con:

- Tipo de documento o soporte.
- Fecha.
- Descripcion breve.
- Nivel de confidencialidad.
- Archivo, como `document_upload_box`.

Tipos sugeridos:

- Consentimiento firmado.
- Documento de identidad.
- Documento civil.
- Informe psicosocial.
- Entrevista de trabajo social.
- Constancia de entrega.
- Fotografia de actividad.
- Otro soporte.

## Recomendacion de flujo

La Solicitud de Localizacion debe ser la puerta de entrada para buscar,
documentar contactos, registrar consentimientos y gestionar la reunificacion.
Cuando se identifican alertas de proteccion o se requiere atencion continuada,
se debe crear o vincular un Caso. De esa forma, las actuaciones de gestion de
casos, servicios, derivaciones y seguimientos permanecen en el modulo que ya
fue disenado para ese fin.

## Decision requerida antes de modificar la interfaz

Confirmar uno de estos enfoques:

1. **Solicitud FTR y Caso vinculado**: usar Solicitudes de Localizacion para
   admision, busqueda y reunificacion; usar Casos para proteccion y seguimiento.
   Este es el enfoque recomendado.
2. **Todo dentro de Solicitudes de Localizacion**: incorporar tambien la
   gestion completa de proteccion y atencion dentro del modulo FTR. Este enfoque
   produce formularios mas largos y duplica funciones existentes.

Despues de confirmar el enfoque se implementara una primera iteracion en la
instancia local, con traducciones al espanol y permisos por rol, antes de
promover la configuracion al VPS.
