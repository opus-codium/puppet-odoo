import os

odoo.tools.config['list_db'] = True

odoo.service.db.exp_drop(os.environ['PT_name'])
