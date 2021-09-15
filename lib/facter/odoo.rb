require 'json'
require 'tempfile'

def try_become_user(user)
  u = Etc.getpwnam(user)
  Process.gid = Process.egid = u.gid
  Process.uid = Process.euid = u.uid
rescue ArgumentError
  # Catch exception raised by getpwnam if `user` does not exist.
  nil # Make older rubocop happy
end

def build_odoo_fact
  IO.popen(['odoo', 'shell', '--config=/etc/odoo/odoo.conf', '--no-http', '--workers=0'], 'r+') do |io|
    io.puts(<<~PYTHON)
      import re
      import json

      res = {}

      parts = re.split('[.-]', odoo.release.version)

      res['release'] = {
        'full': odoo.release.version,
        'major': parts[0],
        'minor': parts[1],
        'date': parts[2],
      }
      if len(parts) > 2:
          res['release']['date'] = parts[2]

      res['databases'] = {}

      def module_info(addon):
          info = odoo.modules.load_information_from_description_file(addon)
          return {
            'name': info.get('name'),
            'version': info.get('version'),
          }

      for dbname in odoo.service.db.list_dbs(True):
          registry = odoo.registry(dbname)
          with registry.cursor() as cr:
              uid = odoo.SUPERUSER_ID
              ctx = odoo.api.Environment(cr, uid, {})['res.users'].context_get()
              env = odoo.api.Environment(cr, uid, ctx)

              res['databases'][dbname] = {}
              regex = re.compile('\\A__\\w*__\\Z')
              res['databases'][dbname]['addons'] = {}
              for addon in dir(odoo.addons):
                  if not regex.match(addon):
                      res['databases'][dbname]['addons'][addon] = module_info(addon)

              cr.rollback()

      print(json.dumps(res))
    PYTHON
    io.close_write
    io.read
  end
end

Facter.add(:odoo) do
  setcode do
    if Facter::Util::Resolution.which('odoo')
      rd, wr = IO.pipe
      pid = Process.fork
      if pid.nil?
        rd.close
        try_become_user('odoo') if Process.gid.zero?
        ENV.delete('HOME')
        wr.write(build_odoo_fact)
        wr.close
        exit! # Mind the `!` to avoid running facter's at_exit function.
      else
        wr.close
        res = rd.read
        rd.close
        Process.wait(pid)
        JSON.parse(res)
      end
    end
  end
end
