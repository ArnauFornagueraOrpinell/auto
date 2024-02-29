#!/bin/bash

read -p "Por favor, introduce la versión de Odoo para instalar Document Management System(por ejemplo, 15): " version

if [[ -z "$version" ]]; then
    echo "Debe ingresar una versión de Odoo."
    exit 1
fi

odoo_version="$version.0"

git clone https://github.com/OCA/dms.git --branch $odoo_version
mv dms a
mv a/dms .
rm -rf a

git clone https://github.com/OCA/web.git --branch $odoo_version
mv web/web_drop_target .
rm -rf web

git clone https://github.com/Nitrokey/odoo-social.git --branch $odoo_version
mv odoo-social/mail_preview_base .
rm -rf odoo-social

odoo_venv="/opt/odoo$version-venv"

systemctl restart odoo$version

echo "INSTALACIÓN DE DMS COMPLETADA CORRECTAMENTE!"