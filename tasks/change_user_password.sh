#!/bin/sh

set -e

/usr/bin/odoo shell --config=/etc/odoo/odoo.conf --no-http --workers=0 --database=${PT_database} < ${PT__installdir}/odoo/files/change-user-password.py
