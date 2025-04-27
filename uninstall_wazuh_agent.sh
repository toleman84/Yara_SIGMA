#!/bin/bash

echo "[+] Deteniendo el servicio wazuh-agent..."
sudo systemctl stop wazuh-agent

# Detectar el tipo de sistema
if [ -f /etc/debian_version ]; then
    echo "[+] Sistema Debian/Ubuntu detectado"
    sudo dpkg --purge wazuh-agent
elif [ -f /etc/redhat-release ]; then
    echo "[+] Sistema RHEL/CentOS detectado"
    sudo rpm -e wazuh-agent
else
    echo "[-] Sistema operativo no soportado automáticamente"
    exit 1
fi

echo "[+] Eliminando archivos residuales..."
sudo rm -rf /var/ossec
sudo rm -rf /etc/ossec-init.conf

echo "[✔] Wazuh Agent desinstalado y limpio."
