#!/bin/bash

read -p "Por favor, introduce la versión de Odoo para instlar facturae(por ejemplo, 15): " version

if [[ -z "$version" ]]; then
    echo "Debe ingresar una versión de Odoo."
    exit 1
fi

odoo_version="$version.0"

cd /opt/odoo/odoo$version-custom-addons

git clone https://github.com/OCA/l10n-spain.git --branch $odoo_version
mv l10n-spain/account_payment_partner .
mv l10n-spain/l10n_es_partner .
mv l10n-spain/l10n_es_facturae .
mv l10n-spain/l10n_es_aeat .
rm -rf l10n-spain

git clone https://github.com/OCA/community-data-files.git --branch $odoo_version
mv community-data-files/base_iso3166 .
mv community-data-files/base_bank_from_iban .
rm -rf community-data-files

git clone https://github.com/OCA/reporting-engine.git --branch $odoo_version
mv reporting-engine/report_qweb_parameter .
mv reporting-engine/report_xml/ .
rm -rf reporting-engine

git clone https://github.com/OCA/bank-payment.git --branch $odoo_version
mv bank-payment/account_payment_partner .
mv bank-payment/account_payment_mode .
rm -rf bank-payment

git clone https://github.com/OCA/account-financial-reporting.git --branch $odoo_version
mv account-financial-reporting/account_tax_balance .
rm -rf account-financial-reporting

git clone https://github.com/OCA/server-ux.git --branch $odoo_version
mv server-ux/date_range .
rm -rf server-ux

odoo_venv="/opt/odoo/odoo$version-venv"

source $odoo_venv/bin/activate
pip install unidecode
pip install pycountry
pip install xmlsig

deactivate

systemctl restart odoo$version

echo "INSTALACIÓN DE FACTURAE COMPLETADA CORRECTAMENTE!"
