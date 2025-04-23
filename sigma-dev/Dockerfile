# Dockerfile para convertir reglas Sigma a Wazuh
FROM python:3.11-slim

LABEL maintainer="Sigma Dev Team <toleman.dev@gmail.com>"
LABEL description="Contenedor para convertir reglas Sigma a reglas Wazuh con sigmac."

# Instalación de dependencias del sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Clonar el repositorio de Sigma
RUN git clone https://github.com/SigmaHQ/sigma.git /opt/sigma

# Establecer directorio de trabajo
WORKDIR /opt/sigma

# Instalar dependencias de Python necesarias para sigmac
RUN pip install PyYAML jsonschema

# Crear un wrapper para ejecutar sigmac.py desde cualquier lugar
RUN echo '#!/bin/bash\npython3 /opt/sigma/tools/sigmac.py "$@"' > /usr/local/bin/sigmac && \
    chmod +x /usr/local/bin/sigmac

# Comando por defecto
CMD ["sigmac", "--help"]
