import base64
import os

odoo.tools.config['list_db'] = True
odoo.service.db.exp_restore(os.environ['PT_name'], base64.b64encode(open(os.environ['PT_filename'], 'rb').read()), os.environ['PT_copy'].lower() in ('yes', 'true', 't', 'y', '1'))
