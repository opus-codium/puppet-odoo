import json
from collections import OrderedDict

res = {}

for dbname in odoo.service.db.list_dbs(True):
    res[dbname] = OrderedDict()
    registry = odoo.registry(dbname)
    with registry.cursor() as cr:
        cr.execute("SELECT key, value FROM ir_config_parameter WHERE key IN ('database.create_date', 'database.enterprise_code', 'database.expiration_date', 'database.expiration_reason', 'web.base.url') ORDER BY key")
        for line in cr.fetchall():
            res[dbname][line[0]] = line[1]

print(json.dumps(res))
