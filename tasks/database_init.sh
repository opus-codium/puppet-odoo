#!/bin/sh

set -e

extra_args=""

if [ "${PT_unaccent}" = true ]; then
  extra_args="${extra_args} --unaccent"
fi

/usr/bin/odoo --config=/etc/odoo/odoo.conf --no-http --workers=0 --database="${PT_name}" --init=all --without-demo=all --stop-after-init $extra_args
