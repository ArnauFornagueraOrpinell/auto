read -p "Por favor, introduce la versión de Odoo para instlar facturae(por ejemplo, 15): " ODOO_VERSION

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