require 'facter'

Facter.add(:odoo) do
  setcode do
    if Facter::Util::Resolution.which('odoo')
      major = minor = date = nil

      begin
        output = Facter::Core::Execution.execute('dpkg-query -W -f=\'${Version}\n\' odoo')
        /^(?<major>\d+)\.(?<minor>\d+)(\+e)?\.(?<date>\d+)$/ =~ output
      rescue Facter::Core::Execution::ExecutionFailure
        output = nil
        begin
          output = Facter::Core::Execution.execute('pip3 show odoo')
        rescue Facter::Core::Execution::ExecutionFailure
          output = Facter::Core::Execution.execute('pip show odoo')
        end
        /^Version: (?<major>\d+)\.(?<minor>\d+)\.post(?<date>\d+)$/ =~ output
      end

      {
        'release' => {
          'full'  => "#{major}.#{minor}.#{date}",
          'major' => major.to_i,
          'minor' => minor.to_i,
          'date'  => date.to_i,
        },
      }
    end
  end
end
