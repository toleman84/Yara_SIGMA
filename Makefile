PROJECT_NAME=wazuh-threat-hunting
SIGMA_IMAGE=sigma-converter
YARA_IMAGE=yara-dev-env
COMPOSE=docker-compose -p $(PROJECT_NAME) -f docker-compose.yml

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

# 🧹 Limpiar volúmenes y red
clean: down
	@echo "[+] Borrando volúmenes y red del entorno..."
	docker volume rm $(PROJECT_NAME)_sigma-rules || true
	docker volume rm $(PROJECT_NAME)_yara-rules || true
	docker network rm $(PROJECT_NAME)_wazuh-net || true

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
