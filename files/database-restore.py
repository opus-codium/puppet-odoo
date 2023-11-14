import base64
import os

odoo.tools.config['list_db'] = True
odoo.service.db.restore_db(os.environ['PT_name'], os.environ['PT_filename'], os.environ['PT_copy'].lower() in ('yes', 'true', 't', 'y', '1'))
