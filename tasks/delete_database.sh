#!/bin/sh

set -e

systemctl stop odoo
sudo -u postgres dropdb "$PT_name"
rm -r ~odoo/.local/share/Odoo/filestore/"$PT_name"
systemctl start odoo
