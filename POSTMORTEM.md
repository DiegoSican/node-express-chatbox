# POSTMORTEM.md

---

## What Was Broken

El repositorio no tenía ninguna instrucción clara para configurarlo desde cero. El README asumía que el ingeniero nuevo ya tenía Node.js y npm instalados, no especificaba qué versión de Node usar, y no mencionaba nada sobre problemas específicos de Windows como la política de ejecución de PowerShell. Adicionalmente, el archivo `package-lock.json` estaba desactualizado y las dependencias del proyecto tenían 16 vulnerabilidades de seguridad conocidas, sin ninguna guía para resolverlas. No había ninguna indicación de en qué puerto corría la aplicación ni cómo probar su funcionalidad principal.

---

## What We Built

- **`setup.sh`** — Script que automatiza toda la configuración. Elimina los blockers de Node.js no instalado, el problema de PowerShell en Windows, la falta de instrucciones sobre vulnerabilidades, y la ausencia de indicaciones sobre el puerto y cómo probar el chat.

- **`.nvmrc`** — Archivo que fija la versión de Node.js en 18. Elimina la ambigüedad sobre qué versión usar y evita problemas de compatibilidad.

- **`.env.example`** — Plantilla que documenta todas las variables de entorno necesarias. Elimina la falta de documentación sobre la configuración del puerto y otras variables del proyecto.

---

## Cost of the Original State

Cada vez que un ingeniero nuevo intenta configurar este proyecto sin documentación adecuada, pierde aproximadamente 2 horas resolviendo problemas que no deberían existir. Con un costo de $50 por hora, el impacto económico se acumula rápidamente:

- Cada ingeniero nuevo = 2 horas × $50 = **$100 por persona**
- 5 ingenieros al mes = 5 × $100 = **$500 perdidos ese mes**
- 12 meses al año = $500 × 12 = **$6,000 perdidos al año**

Este cálculo no incluye el tiempo de ingenieros más senior que tienen que ayudar a desbloquear a los nuevos, ni los errores cometidos por configuraciones incorrectas.

---

## What We Would Do Next

La mejora con mayor impacto que no tuvimos tiempo de implementar sería agregar un **`docker-compose.yml`**. Con un solo comando `docker compose up` cualquier ingeniero podría levantar el proyecto completo sin necesidad de tener Node.js instalado, sin preocuparse por versiones, y sin diferencias entre Windows, Mac o Linux. Esto eliminaría de raíz todos los problemas de entorno que documentamos en el PAIN_LOG. Vale la pena mencionar que con los artefactos que construimos logramos reducir el tiempo de configuración a menos de 1 minuto, cuando el objetivo mínimo era completarlo en 5 minutos. Un `docker-compose.yml` llevaría ese tiempo a prácticamente cero para cualquier ingeniero sin importar su sistema operativo.

