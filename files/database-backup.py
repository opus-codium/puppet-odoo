import os

odoo.tools.config['list_db'] = True

with open(os.environ['PT_filename'], mode='w+b') as t:
    odoo.service.db.dump_db(os.environ['PT_name'], t, os.environ['PT_format'])
