import os

odoo.tools.config['list_db'] = True
odoo.service.db.exp_restore(os.environ['PT_name'], os.environ['PT_filename'], os.environ['PT_copy'].lower() in ('yes', 'true', 't', 'y', '1'))
