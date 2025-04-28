FROM python:3.11-slim

LABEL maintainer="Sigma Dev Team <toleman.dev@gmail.com>"
LABEL description="Contenedor para convertir reglas Sigma a Wazuh con sigma-cli"

# Dependencias básicas
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Clonar repositorio oficial de Sigma
RUN git clone https://github.com/SigmaHQ/sigma.git /opt/sigma

# Establecer directorio de trabajo
WORKDIR /opt/sigma

# Instalar sigma como CLI
RUN pip install --upgrade pip
RUN pip install sigma-cli PyYAML jsonschema

# Comando por defecto (ayuda de sigma)
ENTRYPOINT ["sigma"]
CMD ["sh", "-c", "while sleep 3600; do :; done"]
