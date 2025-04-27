#!/bin/bash

# Variables
WAZUH_MANAGER_IP="127.0.0.1" # <<< Cambiá esto si tu manager no está local

# Detectar si es Debian/Ubuntu o RHEL/CentOS
if [ -f /etc/debian_version ]; then
    echo "[+] Sistema Debian/Ubuntu detectado"
    curl -sO https://packages.wazuh.com/4.4/wazuh-agent_4.4.0-1_amd64.deb
    sudo dpkg -i wazuh-agent_4.4.0-1_amd64.deb
elif [ -f /etc/redhat-release ]; then
    echo "[+] Sistema RHEL/CentOS detectado"
    curl -sO https://packages.wazuh.com/4.4/wazuh-agent-4.4.0-1.x86_64.rpm
    sudo rpm -i wazuh-agent-4.4.0-1.x86_64.rpm
else
    echo "[-] Sistema operativo no soportado automáticamente"
    exit 1
fi

# Configurar IP del Manager
echo "[+] Configurando Wazuh Agent para conectarse a $WAZUH_MANAGER_IP"
sudo sed -i "s|<address>.*</address>|<address>${WAZUH_MANAGER_IP}</address>|g" /var/ossec/etc/ossec.conf

# Habilitar y arrancar servicio
echo "[+] Habilitando y arrancando el servicio Wazuh Agent"
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl restart wazuh-agent

echo "[✔] Wazuh Agent instalado y corriendo!"
