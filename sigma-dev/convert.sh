#!/bin/bash
# convert.sh

INPUT_DIR=/sigma-src
OUTPUT_DIR=/converted

for file ind $INPUT_DIR/*.yml; do
    echo "Convirtiendo $file..."
    sigmac -t wazuh -c ·SIGMA_ROOT/tools/config/wazuh/wazuh.yml "$file" -o "$OUTPUT_DIR/$(basename "$file" .yml).xml"
done
echo "Conversión completada. Los archivos convertidos se encuentran en $OUTPUT_DIR."
# Convertir los archivos de configuración de Wazuh a Sigma
