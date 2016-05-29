require "find"
require "get_pomo"
require "json"

def main
  if ARGV.length != 1
    puts "ruby #{$0} <translation path>"
    exit 1
  end


  tr_list = []
  Find.find(ARGV[0]) do |path|
    if path =~ /\.po$/
      GetPomo::PoFile.parse(File.read(path), :parse_obsoletes => true).each do |tr|
        tr_list << {:en => tr.msgid, :th => tr.msgstr}
      end
    end
  end

  puts tr_list.to_json
end

main
