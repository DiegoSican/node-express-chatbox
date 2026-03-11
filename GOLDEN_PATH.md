# GOLDEN_PATH.md 

---

## ¿Qué es este documento?

Después de identificar los problemas en el PAIN_LOG.md, cambiamos de rol y nos convertimos en el equipo de plataforma. Usamos IA para generar los artefactos que eliminan cada blocker encontrado. Este documento explica qué se construyó y qué tuvimos que corregir manualmente.

---

## Artefactos creados

### 1. `setup.sh`
Script que automatiza toda la configuración del proyecto de principio a fin.

**¿Qué hace paso a paso?**
- Verifica que Node.js esté instalado. Si no lo está, le dice al usuario exactamente dónde descargarlo
- Verifica que npm funcione. Si falla en Windows, muestra el comando exacto para arreglarlo
- Revisa que la versión de Node sea v18 o superior
- Copia automáticamente `.env.example` a `.env` si no existe
- Instala las dependencias con `npm install`
- Avisa sobre vulnerabilidades de seguridad y cómo resolverlas
- Al final indica en qué URL abrir la app y cómo probarla con múltiples usuarios

**Cómo usarlo:**
```bash
bash setup.sh
```

---

### 2. `.nvmrc`
Archivo que contiene únicamente el número `18`. Le indica qué versión de Node.js usar en este proyecto. Para usarlo se necesita tener `nvm` instalado y correr el comando `nvm use`. En Windows es posible que este comando no funcione porque `nvm` no viene instalado por defecto, lo cual es completamente normal y no impide correr el proyecto. En ese caso se puede ignorar este paso y usar directamente `bash setup.sh`.

---

### 3. `.env.example`
Plantilla que documenta todas las variables necesarias para correr el proyecto, con comentarios que explican cada variable y sus valores válidos. El `setup.sh` copia este archivo automáticamente como `.env`, por lo que no es necesario hacerlo a mano.

**Cómo usarlo manualmente si se necesita:**
```bash
cp .env.example .env
```

---

## Tabla: Pain Point → Artefacto → Estado

| Pain Point # | Descripción del problema | Artefacto que lo resuelve | Estado |
|---|---|---|---|
| 1 | No se menciona que hay que instalar Node.js y npm | `setup.sh` — verifica e informa si falta Node/npm con mensaje claro | ✅ Resuelto |
| 2 | PowerShell en Windows bloquea npm por defecto | `setup.sh` — muestra instrucciones específicas para Windows | ✅ Resuelto |
| 3 | package-lock.json desactualizado genera advertencias | `setup.sh` — ejecuta npm install y explica las advertencias | ✅ Resuelto |
| 4 | 16 vulnerabilidades sin guía para resolverlas | `setup.sh` — corre npm audit y sugiere npm audit fix | ✅ Resuelto |
| 5 | No se documenta el puerto donde corre la app | `setup.sh` + `.env.example` — indica claramente http://localhost:3001 | ✅ Resuelto |
| 6 | No hay instrucciones para probar entre dos máquinas | `setup.sh` — menciona opciones de prueba local | 🔶 Parcial |
| 7 | No se explica cómo simular múltiples usuarios | `setup.sh` — explica abrir múltiples pestañas o dos navegadores distintos | ✅ Resuelto |

---

## What the AI Got Wrong

**Error 1 — Olvidó a los usuarios de Windows**  
El primer borrador del `setup.sh` no tenía ninguna instrucción para Windows. La IA asumió que todos usan Mac o Linux y no mencionó nada sobre el problema de PowerShell. Tuvimos que agregar manualmente el mensaje que explica cómo habilitarlo con `Set-ExecutionPolicy`, que era uno de los dos BLOCKERs principales del proyecto.

**Error 2 — Recomendó una versión de Node que ya no tiene soporte**  
La IA sugirió usar Node.js v12 porque el proyecto es de 2019. El problema es que Node v12 dejó de recibir actualizaciones de seguridad en 2022, lo que significa que usarla sería incluso más inseguro que el proyecto original. Tuvimos que cambiarla a Node v18, que es la versión estable y segura recomendada actualmente.

**Error 3 — Generó archivos que no se hablaban entre sí**  
La IA creó el `setup.sh` y el `.env.example` como dos archivos separados sin ninguna conexión. El usuario tenía que copiar manualmente el `.env.example` antes de correr el script, lo cual seguía siendo un paso sin documentar. Tuvimos que modificar el `setup.sh` para que copie el `.env.example` automáticamente, haciendo que todo funcione con un solo comando.

**Error 4 — El .nvmrc asumió que nvm está instalado en todos los sistemas**  
La IA documentó `nvm use` como si fuera un comando disponible en cualquier computadora. Al probarlo en Windows con Git Bash apareció el error `nvm: command not found` porque `nvm` no viene instalado por defecto en Windows. Tuvimos que aclarar en la documentación que este paso es opcional y que no afecta el funcionamiento del proyecto.

