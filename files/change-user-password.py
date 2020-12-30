import os

u = env['res.users'].search([('login', '=', os.environ['PT_login'])])

u._set_encrypted_password(u.id, os.environ['PT_password'])

env.cr.commit()
