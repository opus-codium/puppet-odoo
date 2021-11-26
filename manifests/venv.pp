# @summary Manage odoo virtual env
#
# @api private
class odoo::venv {
  assert_private()

  if $odoo::manage_venv and $odoo::install_from == 'vcsrepo' {
    python::pyvenv { $odoo::venv_path:
    }

    python::requirements { "${odoo::vcsrepo_path}/requirements.txt":
      virtualenv          => $odoo::venv_path,
      manage_requirements => false,
    }
  }
}
