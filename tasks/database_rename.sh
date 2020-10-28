#!/bin/sh

set -e

/usr/bin/odoo shell --config=/etc/odoo/odoo.conf --no-http --workers=0 < ${PT__installdir}/odoo/files/database-rename.py
