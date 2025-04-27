🖥 Script de instalación automática: install_wazuh_agent.sh

⚡ Cómo usarlo
Guardalo como install_wazuh_agent.sh

Dale permisos de ejecución:

bash
chmod +x install_wazuh_agent.sh
Ejecutalo:

bash
sudo ./install_wazuh_agent.sh
Fin del misterio. 🎩🐇

🔥 Detalles extra:
Si tu manager no está en 127.0.0.1, editá la línea:

bash
WAZUH_MANAGER_IP="IP_REAL"
El script detecta automáticamente si usás .deb o .rpm.

Si después querés ver si conectó, podés correr:

bash
sudo tail -f /var/ossec/logs/ossec.log

========================

🧹 Script de desinstalación: uninstall_wazuh_agent.sh

⚡ Cómo usarlo:
Guardalo como uninstall_wazuh_agent.sh

Dale permisos de ejecución:

bash
chmod +x uninstall_wazuh_agent.sh
Ejecutalo:

bash
sudo ./uninstall_wazuh_agent.sh
🔥 Notas rápidas:
Borra todo: binarios, configuraciones, logs.

Elimina también /var/ossec y /etc/ossec-init.conf por si quedaron archivos de configuraciones.

Si instalaste a mano, este método también limpia.
