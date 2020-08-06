#!/bin/sh

set -e

if [ ! -f "${PT_filename}" ]; then
	echo "The backup ${PT_filename} MUST exist" >&2
	exit 1
fi

if [ -d ~odoo/.local/share/Odoo/filestore/"${PT_name}" ]; then
	echo "The database ${PT_name} MUST NOT exist" >&2
	exit 1
fi

TMPDIR=`mktemp -d`

(
	cd "$TMPDIR"
	unzip "${PT_filename}"
)
chown -R odoo:odoo "${TMPDIR}/filestore"
mv "${TMPDIR}/filestore" ~odoo/.local/share/Odoo/filestore/"${PT_name}"
sudo -u postgres createdb -Oodoo -Eunicode "${PT_name}"
sudo -u postgres psql "${PT_name}" < "${TMPDIR}/dump.sql"

rm -r "${TMPDIR}"
