#!/bin/sh

set -e

old_path=~odoo/.local/share/Odoo/filestore/"$PT_oldname"
new_path=~odoo/.local/share/Odoo/filestore/"$PT_newname"

if [ ! -d "$old_path" ]; then
	echo "Old filestore MUST exist" >&2
	exit 1
fi

if [ -e "$new_path" ]; then
	echo "New filestore MUST NOT exist" >&2
	exit 1
fi

systemctl stop odoo
sudo -u postgres psql template1 -c '\set ON_ERROR_STOP on' -c "ALTER DATABASE \"$PT_oldname\" RENAME TO \"$PT_newname\";"
mv ~odoo/.local/share/Odoo/filestore/"$PT_oldname" ~odoo/.local/share/Odoo/filestore/"$PT_newname"
systemctl start odoo
