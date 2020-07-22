#!/bin/sh

set -e

if [ -f "${PT_filename}" ]; then
	echo "The backup ${PT_filename} MUST NOT exist" >&2
	exit 1
fi

if [ ! -d ~odoo/.local/share/Odoo/filestore/"${PT_name}" ]; then
	echo "The database ${PT_name} MUST exist" >&2
	exit 1
fi

TMPDIR=`mktemp -d`

cp -R ~odoo/.local/share/Odoo/filestore/"${PT_name}" "${TMPDIR}/filestore"
find "${TMPDIR}/filestore" -type d -empty -delete
sudo -u postgres pg_dump --no-owner "${PT_name}" > "${TMPDIR}/dump.sql"
(
	cd "$TMPDIR"
	zip -qr "${PT_filename}" filestore dump.sql
)

rm -r "${TMPDIR}"
