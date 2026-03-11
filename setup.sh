#!/bin/bash

# =============================================================
# setup.sh — Script de configuración automática
# Proyecto: node-express-chatbox
# Uso: bash setup.sh
# =============================================================

# Colores para los mensajes en la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

echo ""
echo "================================================="
echo "   Configuración automática: node-express-chatbox"
echo "================================================="
echo ""

# -------------------------------------------------------------
# PASO 1 — Verificar que Node.js está instalado
# Resuelve: Friction Point #1 [IMPLICIT_DEP]
# -------------------------------------------------------------
echo "Verificando Node.js..."

if ! command -v node &> /dev/null; then
  echo -e "${RED}[ERROR] Node.js no está instalado.${NC}"
  echo ""
  echo "Por favor instálalo desde: https://nodejs.org"
  echo "Se recomienda la versión LTS."
  echo ""
  echo "Si estás en Windows y npm no funciona en PowerShell, ejecuta"
  echo "esto como Administrador:"
  echo "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
  echo ""
  exit 1
fi

NODE_VERSION=$(node --version)
echo -e "${GREEN}[OK] Node.js encontrado: $NODE_VERSION${NC}"

# -------------------------------------------------------------
# PASO 2 — Verificar que npm está instalado
# Resuelve: Friction Point #1 y #2 [IMPLICIT_DEP]
# -------------------------------------------------------------
echo ""
echo "Verificando npm..."

if ! command -v npm &> /dev/null; then
  echo -e "${RED}[ERROR] npm no está instalado o no está en el PATH.${NC}"
  echo ""
  echo "Si estás en Windows con PowerShell, ejecuta como Administrador:"
  echo "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
  echo "Luego cierra y vuelve a abrir la terminal."
  exit 1
fi

NPM_VERSION=$(npm --version)
echo -e "${GREEN}[OK] npm encontrado: v$NPM_VERSION${NC}"

# -------------------------------------------------------------
# PASO 3 — Verificar versión mínima de Node (recomendado v18+)
# Resuelve: Friction Point #3 [VERSION_HELL]
# -------------------------------------------------------------
echo ""
echo "Verificando versión de Node.js..."

NODE_MAJOR=$(node --version | cut -d'.' -f1 | sed 's/v//')

if [ "$NODE_MAJOR" -lt 18 ]; then
  echo -e "${YELLOW}[ADVERTENCIA] Estás usando Node.js v$NODE_MAJOR.${NC}"
  echo "Este proyecto recomienda Node.js v18 o superior."
  echo "Puedes continuar pero podrías encontrar errores inesperados."
  echo ""
else
  echo -e "${GREEN}[OK] Versión de Node.js compatible.${NC}"
fi

# -------------------------------------------------------------
# PASO 4 — Copiar .env.example a .env si no existe
# Resuelve: Friction Point #5 [MISSING_DOC]
# -------------------------------------------------------------
echo ""
echo "Verificando archivo de configuración .env..."

if [ ! -f .env ]; then
  cp .env.example .env
  echo -e "${GREEN}[OK] Archivo .env creado desde .env.example${NC}"
  echo -e "${YELLOW}[INFO] Puedes editar .env para cambiar el puerto u otras opciones.${NC}"
else
  echo -e "${GREEN}[OK] Archivo .env ya existe, no se sobreescribe.${NC}"
fi

# -------------------------------------------------------------
# PASO 5 — Instalar dependencias
# Resuelve: Friction Point #1 y #4 [IMPLICIT_DEP]
# -------------------------------------------------------------
echo ""
echo "Instalando dependencias..."

npm install

if [ $? -ne 0 ]; then
  echo -e "${RED}[ERROR] Falló la instalación de dependencias.${NC}"
  echo "Revisa tu conexión a internet e intenta de nuevo."
  exit 1
fi

echo -e "${GREEN}[OK] Dependencias instaladas correctamente.${NC}"

# -------------------------------------------------------------
# PASO 6 — Avisar sobre vulnerabilidades de seguridad
# Resuelve: Friction Point #4 [IMPLICIT_DEP]
# -------------------------------------------------------------
echo ""
echo -e "${YELLOW}[INFO] Revisando vulnerabilidades de seguridad...${NC}"
npm audit --audit-level=critical 2>/dev/null || true
echo ""
echo -e "${YELLOW}[INFO] Si ves vulnerabilidades, puedes intentar resolverlas con:${NC}"
echo "  npm audit fix"
echo ""

# -------------------------------------------------------------
# PASO 7 — Todo listo
# Resuelve: Friction Point #5, #6 y #7 [MISSING_DOC]
# -------------------------------------------------------------
echo "================================================="
echo -e "${GREEN}   ¡Configuración completada exitosamente!${NC}"
echo "================================================="
echo ""
echo "Para iniciar la aplicación elige una opción:"
echo ""
echo "  Opción A (con auto-recarga al guardar cambios):"
echo "    npx nodemon server.js"
echo ""
echo "  Opción B (sin instalar nada extra):"
echo "    node server.js"
echo ""
echo "Luego abre tu navegador en: http://localhost:3001"
echo ""
echo "Para probar el chat con varios usuarios:"
echo "  - Abre varias pestañas en http://localhost:3001"
echo "  - O usa dos navegadores distintos (ej: Chrome y Edge)"
echo ""
