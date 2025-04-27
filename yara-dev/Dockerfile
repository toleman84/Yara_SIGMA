FROM debian:bullseye-slim

LABEL maintainer="Sigma Dev Team <toleman.dev@gmail.com>"
LABEL description="Contenedor de desarrollo para reglas YARA integradas con Wazuh"

# Instalamos dependencias y YARA
RUN apt-get update && \
    apt-get install -y \
        git \
        make \
        automake \
        libtool \
        pkg-config \
        libssl-dev \
        libjansson-dev \
        libmagic-dev \
        yara && \
    apt-get clean

# Crear carpeta de trabajo
WORKDIR /yara

# Comando por defecto
CMD ["sh", "-c", "while sleep 3600; do :; done"]
