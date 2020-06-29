#!/usr/bin/env ruby

require 'json'
require 'open3'

params = JSON.parse(STDIN.read)
KEYS = params['keys']

def read_manifest(addon)
  script = <<~PYTHON
    import json
    with open('__manifest__.py') as f: manifest = json.dumps(eval(f.read()))
    print(manifest)
  PYTHON

  manifest = nil

  Dir.chdir addon do
    stdout, status = Open3.capture2('/usr/bin/env python3', stdin_data: script)
    manifest = JSON.parse(stdout) if status.success? 
  end

  manifest
end

def list_addons_from_path(path)
  out = {}

  Dir.glob("#{path}/*").sort.each do |addon|

    name = File.basename addon
    next if name.match(/^__.*/) || File.file?(addon)

    manifest = read_manifest(addon)
    manifest = manifest.slice(*KEYS.split(',')) unless (KEYS == 'all' || manifest.nil?)

    out[name] = manifest
  end

  out
end

conf_file = '/etc/odoo/odoo.conf'
raise "Configuration file not found #{conf_file}" unless File.exist? conf_file

content = File.read conf_file

line = /^addons_path\s?=\s?(.*)$/i.match content
raise 'Addons path not found in configuration' unless line

paths = line[1].split(',').map(&:strip)

output = paths.map do |dir|
  #[dir, Dir.glob("#{dir}/*").sort.map{|e| e.sub("#{dir}/", '')}.reject{|e| e.match(/^__.*/)}]
  [dir, list_addons_from_path(dir)]
end.to_h.to_json

puts output
