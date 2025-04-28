#!/bin/bash
RULES_DIR="/rules"
TARGET_DIR="${1:-/scan}"  # Si no pasas argumento, usa /scan

echo "[*] Iniciando escaneo de $TARGET_DIR con reglas en $RULES_DIR"

# Verificar que el directorio de reglas existe
if [ ! -d "$RULES_DIR" ]; then
    echo "[!] Error: No existe el directorio de reglas: $RULES_DIR"
    exit 1
fi

# Verificar que el directorio objetivo existe
if [ ! -d "$TARGET_DIR" ]; then
    echo "[!] Error: No existe el directorio a escanear: $TARGET_DIR"
    exit 1
fi

# Buscar reglas
RULES_FOUND=false
for rule in "$RULES_DIR"/*.yar; do
    if [ -f "$rule" ]; then
        RULES_FOUND=true
        echo "==> Escaneando con regla: $rule"
        yara -r "$rule" "$TARGET_DIR" || echo "[!] Error al aplicar $rule"
    fi
done

if [ "$RULES_FOUND" = false ]; then
    echo "[!] No se encontraron reglas .yar en $RULES_DIR"
fi

echo "[*] Escaneo completado."
