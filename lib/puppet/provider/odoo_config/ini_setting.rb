Puppet::Type.type(:odoo_config).provide(:ini_setting, parent: Puppet::Type.type(:ini_setting).provider(:ruby)) do
  def section
    'options'
  end

  def setting
    resource[:name]
  end

  def separator
    ' = '
  end

  def self.file_path
    '/etc/odoo/odoo.conf'
  end
end
