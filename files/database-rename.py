import os

odoo.tools.config['list_db'] = True
odoo.service.db.exp_rename(os.environ['PT_oldname'], os.environ['PT_newname'])
