
read -p "Por favor, introduce la dirección IP del servidor: " SERVER_IP
read -p "Por favor, introduce el usuario: " USER
read -sp "Por favor, introduce la contraseña de SSH para $SERVER_IP: " PASSWORD
read -p "Por favor, introduce la versión de Odoo para instlar facturae(por ejemplo, 15): " ODOO_VERSION


if [ "$ODOO_VERSION" == "14" || "$ODOO_VERSION" == "15" || "$ODOO_VERSION" == "16" || "$ODOO_VERSION" == "17" ]; then
    echo "La versión de Odoo es válida"
else
    echo "La versión de Odoo no es válida"
    exit 1
fi

sshpass -p "$PASSWORD" ssh root@$SERVER_IP << EOF
    cd /opt/odoo/odoo$ODOO_VERSION-custom-addons
    
    git clone https://github.com/OCA/l10n-spain.git --branch $ODOO_VERSION.0
    mv l10n-spain/account_payment_partner .
    mv l10n-spain/l10n_es_partner .
    mv l10n-spain/l10n_es_facturae .
    mv l10n-spain/l10n_es_aeat .

    git clone https://github.com/OCA/community-data-files.git --branch $ODOO_VERSION.0
    mv community-data-files/base_iso3166 .
    mv community-data-files/base_bank_from_iban .

    git clone git clone https://github.com/OCA/reporting-engine.git --branch $ODOO_VERSION.0
    mv reporting-engine/report_qweb_parameter .
    mv reporting-engine/report_xml/ .

    git clone https://github.com/OCA/bank-payment.git --branch $ODOO_VERSION.0
    mv bank-payment/account_payment_partner .
    mv bank-payment/account_payment_mode .

    git clone https://github.com/OCA/account-financial-reporting.git --branch $ODOO_VERSION.0
    mv account-financial-reporting/account_tax_balance .

    git clone https://github.com/OCA/server-ux.git --branch $ODOO_VERSION.0
    mv server-ux/date_range .

    source ../odoo$ODOO_VERSION-venv/bin/activate
    pip install unidecode
    pip install pycountry
    pip install xmlsig
    deactivate

    systemctl restart odoo$ODOO_VERSION
EOF
