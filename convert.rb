#!/usr/bin/env ruby

# Yaml parser via https://gist.github.com/johncarney/7332f7b2075b86ea52177a4a82453806

require "psych"
require "pp"

ValueWithLineNumbers = Struct.new(:value, :line)

class Psych::Nodes::ScalarWithLineNumber < Psych::Nodes::Scalar
  attr_reader :line_number

  def initialize(*args, line_number)
    super(*args)
    @line_number = line_number
  end
end

class Psych::TreeWithLineNumbersBuilder < Psych::TreeBuilder
  attr_accessor :parser

  def scalar(*args)
    node = Psych::Nodes::ScalarWithLineNumber.new(*args, parser.mark.line)
    @last.children << node
    node
  end
end

class Psych::Visitors::ToRubyWithLineNumbers < Psych::Visitors::ToRuby
  def visit_Psych_Nodes_ScalarWithLineNumber(node)
    visit_Psych_Nodes_Scalar(node)
  end

  private

  def revive_hash(hash, node)
    node.children.each_slice(2) do |k, v|
      key = accept(k)
      val = accept(v)

      if v.is_a? Psych::Nodes::ScalarWithLineNumber
        start_line = end_line = v.line_number + 1

        if k.is_a? Psych::Nodes::ScalarWithLineNumber
          start_line = k.line_number + 1
        end
        val = ValueWithLineNumbers.new(val, "#{start_line-1},#{start_line-1}")
      end

      if key == SHOVEL && k.tag != "tag:yaml.org,2002:str"
        case v
        when Psych::Nodes::Alias, Psych::Nodes::Mapping
          begin
            hash.merge! val
          rescue TypeError
            hash[key] = val
          end
        when Psych::Nodes::Sequence
          begin
            h = {}
            val.reverse_each do |value|
              h.merge! value
            end
            hash.merge! h
          rescue TypeError
            hash[key] = val
          end
        else
          hash[key] = val
        end
      else
        hash[key] = val
      end
    end

    hash
  end
end

def truncate(text, length = 100, truncate_string = '...')
  if text
    l = length - truncate_string.chars.length
    (text.length > length ? text[0...l] + truncate_string : text).to_s
  end
end

def proposed_filename(thing)
  name = thing["name"].value
  truncate(name.downcase.gsub(/[^0-9a-z]/,'-'), 50) + ".yml"
end

require 'yaml'
thing = YAML.load_file('_data/companies.yml')
yaml_string = YAML.dump(thing)

handler = Psych::TreeWithLineNumbersBuilder.new
handler.parser = Psych::Parser.new(handler)

handler.parser.parse(yaml_string)

ruby_with_line_numbers = Psych::Visitors::ToRubyWithLineNumbers.create.accept(handler.root)[0]

ruby_with_line_numbers.each { |t|
  destination = File.join("_data", "companies", proposed_filename(t))

  new_obj = {}
  t.each do |key, val| 
    new_obj[key] = val.value
  end
  File.open( destination, 'w' ) do |out|
    YAML.dump( new_obj, out )
  end

  name_line = t["name"].line
  commit_raw = `git blame -p -L #{name_line} _data/companies.yml`
  author = (commit_raw.lines[1][7..-2] + commit_raw.lines[2][11..-2]).strip
  
  puts "Committing #{destination} as \"#{author}\"..."
  `git add #{destination}`
  `git commit --author="#{author}" -m "Migrate company '#{truncate(t["name"].value, 20)}'."`
  
}
