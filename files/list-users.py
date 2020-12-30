import json
import os

if os.environ.get('PT_contains'):
  search_filter = [('login', 'like', os.environ['PT_contains'])]
else:
  search_filter = []

users = env['res.users'].search(search_filter)

print(json.dumps(users.mapped('login')))
