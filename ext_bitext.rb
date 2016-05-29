require "find"
require "get_pomo"
require "xliffer"
require "json"


class String
  def encode_tu
    self.gsub('|||', 'III').gsub("\n", "<br>")
  end
end

def main
  if ARGV.length != 1
    puts "ruby #{$0} <translation path>"
    exit 1
  end


  tr_list = []
  Find.find(ARGV[0]) do |path|
    if path =~ /\.po$/
      GetPomo::PoFile.parse(File.read(path), :parse_obsoletes => true).each do |tr|
        puts "#{tr.msgid.encode_tu} ||| #{tr.msgstr.encode_tu}"
      end
    elsif path =~ /\.xliff$/
      XLIFFer::XLIFF.new(File.open(path)).files.each do |file|
        file.strings.each do |s|
          puts "#{s.source.encode_tu} ||| #{s.target.encode_tu}"
        end
      end
    end
  end
end

main
