PROJECT_NAME=wazuh-threat-hunting
SIGMA_IMAGE=sigma-converter
YARA_IMAGE=yara-dev-env
COMPOSE=docker-compose -p $(PROJECT_NAME) -f docker-compose.yml
CONTAINERS = wazuh-indexer wazuh-manager wazuh-dashboard yara-dev sigma-dev

# 🔧 Build custom containers
build:
	@echo "[+] Construyendo imagen de Sigma..."
	docker build -t $(SIGMA_IMAGE) ./sigma-dev
	@echo "[+] Construyendo imagen de YARA..."
	docker build -t $(YARA_IMAGE) ./yara-dev

# 🚀 Levantar todos los contenedores
up: build
	@echo "[+] Levantando entorno con Docker Compose..."
	$(COMPOSE) up -d

# 🛑 Detener contenedores
down:
	@echo "[+] Deteniendo contenedores..."
	$(COMPOSE) down

# 🧪 Ejecutar conversión Sigma → Wazuh
convert-sigma:
	@echo "[*] Ejecutando conversión de reglas Sigma..."
	docker exec -it sigma-dev bash /opt/sigma/convert.sh

# 🔍 Ejecutar escaneo YARA
scan-yara:
	@echo "[*] Ejecutando escaneo YARA..."
	docker exec -it yara-dev bash /yara/scan.sh

# 🔎 Acceder a contenedor (bash interactivo)
shell-%:
	@echo "[*] Accediendo a contenedor $*..."
	docker exec -it $* bash

.PHONY: start stop restart status

# Solo levantar los contenedores existentes
start:
	@echo "[+] Iniciando contenedores existentes..."
	docker start $(CONTAINERS)

# Detener los contenedores
stop:
	@echo "[+] Deteniendo contenedores..."
	docker stop $(CONTAINERS)

# Detener y luego iniciar
restart:
	@echo "[+] Reiniciando contenedores..."
	make stop
	make start

# Verificar el estado
status:
	@echo "[+] Estado de los contenedores:"
	docker ps -a --filter "name=wazuh" --filter "name=yara-dev" --filter "name=sigma-dev"
