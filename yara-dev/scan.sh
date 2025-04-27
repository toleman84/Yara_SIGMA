#!/bin/bash
RULES_DIR="/rules"
TARGET_DIR="/scan"

echo "[*] Escaneando $TARGET_DIR con reglas en $RULES_DIR"
for rule in $RULES_DIR/*.yar; do
    echo "==> Regla: $rule"
    yara -r "$rule" "$TARGET_DIR"
done
