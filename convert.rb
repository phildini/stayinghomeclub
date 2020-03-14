#!/usr/bin/env ruby

def truncate(text, length = 100, truncate_string = '...')
  if text
    l = length - truncate_string.chars.length
    (text.length > length ? text[0...l] + truncate_string : text).to_s
  end
end

def proposed_filename(thing)
  name = thing["name"]
  truncate(name.downcase.gsub(/[^0-9a-z]/,'-'), 50) + ".yml"
end

require 'yaml'
thing = YAML.load_file('old-company-data.yml')

thing.each { |t|
  destination = File.join("_data", "companies", proposed_filename(t))

  File.open( destination, 'w' ) do |out|
    YAML.dump( t, out )
  end

  puts "Committing #{destination}..."
  `git add #{destination}`
  `git commit -m "Migrate company '#{truncate(t["name"],20)}'."`
}
