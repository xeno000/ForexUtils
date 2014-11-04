require 'fileutils'
require 'open-uri'
require 'zipruby'

class ForexDataFile
    def initialize(path)
        @path = path
    end
    
    def read
        Zip::Archive.open(@path) do |archive|
            archive.num_files.times do |i|
                entry_name = archive.get_name(i)

                archive.fopen(entry_name) do |f| 
                    @read = f.read
                end
            end
        end
    end
    
    def select_forex_data_line_array(currency_pair)
        array = Array.new
        @read.lines do |line|
            if line.include?(currency_pair)
                array.push(line)
            end
        end
        array
    end
end