#!/bin/sh

set -e

/usr/bin/odoo --config=/etc/odoo/odoo.conf --no-http --workers=0 --database="${PT_name}" --update=all --stop-after-init
