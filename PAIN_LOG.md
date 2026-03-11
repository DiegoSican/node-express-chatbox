# PAIN_LOG.md

---

## Puntos de Fricción

**1. [IMPLICIT_DEP]** El README asume que Node.js y npm ya están instalados en la computadora, pero no da ninguna instrucción para instalarlos. Al intentar correr `npm install` en una máquina limpia con Windows, la terminal no reconoce el comando y no da ninguna pista de qué hacer.  
**Severidad: BLOCKER** — Sin npm instalado no se puede hacer absolutamente nada. El ingeniero nuevo queda bloqueado desde el primer paso.

---

**2. [IMPLICIT_DEP]** En Windows, PowerShell tiene los scripts deshabilitados por defecto. Esto hace que npm no funcione aunque ya esté instalado, mostrando un error de permisos. El README no menciona este problema ni cómo solucionarlo (cambiar la política de ejecución con `Set-ExecutionPolicy`).  
**Severidad: BLOCKER** — npm no corre en Windows sin aplicar este fix. Un ingeniero nuevo puede perder entre 30 y 60 minutos buscando la solución por su cuenta.

---

**3. [VERSION_HELL]** El archivo `package-lock.json` fue generado con una versión antigua de npm. Al correr `npm install` aparece la advertencia `old lockfile` y el proceso tarda más porque tiene que buscar información extra desde internet. Además, el README no menciona nada sobre esto ni cómo resolverlo.  
**Severidad: MEDIUM** — La instalación termina pero con advertencias confusas que no tienen explicación en la documentación.

---

**4. [IMPLICIT_DEP]** Al correr `npm install` aparecen **16 vulnerabilidades de seguridad** (3 críticas, 7 altas, 2 medias, 4 bajas) en las dependencias del proyecto. El README no menciona estos problemas de seguridad ni recomienda ningún paso para resolverlos como `npm audit fix`. Estas vulnerabilidades son comunes en proyectos viejos de Node.js que no han actualizado sus librerías.  
**Severidad: MEDIUM** — El proyecto instala y corre, pero el ingeniero queda con dudas sobre si es seguro usarlo.

---

**5. [MISSING_DOC]** El README no menciona en qué puerto corre la aplicación. Después de iniciar el servidor hay que leer el mensaje en la terminal (`Listening to requests on port 3001`) o buscar directamente en el código para descubrir que hay que abrir `http://localhost:3001` en el navegador.  
**Severidad: LOW** — La app corre correctamente pero el ingeniero no sabe dónde abrirla.

---

**6. [MISSING_DOC]** El README no explica cómo probar la aplicación entre dos máquinas diferentes o desde redes distintas. La única forma que se descubrió fue abriendo varias pestañas en el mismo navegador de forma local. No hay instrucciones sobre cómo compartir el acceso con otra persona fuera de la misma computadora.  
**Severidad: MEDIUM** — Un equipo que quiera hacer pruebas reales entre dos personas no tiene ninguna guía de cómo hacerlo.

---


## Resumen de Severidad

| # | Etiqueta | Descripción | Severidad |
|---|----------|-------------|-----------|
| 1 | `[IMPLICIT_DEP]` | No se menciona que hay que instalar Node.js y npm | BLOCKER |
| 2 | `[IMPLICIT_DEP]` | PowerShell en Windows bloquea npm por defecto | BLOCKER |
| 3 | `[VERSION_HELL]` | package-lock.json desactualizado genera advertencias al instalar | MEDIUM |
| 4 | `[IMPLICIT_DEP]` | 16 vulnerabilidades de seguridad sin ninguna guía para resolverlas | MEDIUM |
| 5 | `[MISSING_DOC]` | No se documenta el puerto donde corre la app | LOW |
| 6 | `[MISSING_DOC]` | No hay instrucciones para probar entre dos máquinas o redes | MEDIUM |

---

- **Total de puntos de fricción encontrados:** 6  
- **Primer bloqueo completo en:** Paso 1 — el comando `npm install` falla de inmediato en Windows antes de poder hacer cualquier otra cosa.  
- **Tiempo estimado perdido para un ingeniero nuevo:** entre 15 y 20 minutos dependiendo de si usa Windows o Mac/Linux y qué tan familiar esté con estas herramientas.
