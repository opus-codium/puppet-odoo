import os

odoo.tools.config['list_db'] = True
odoo.service.db.exp_duplicate_database(os.environ['PT_oldname'], os.environ['PT_newname'])
