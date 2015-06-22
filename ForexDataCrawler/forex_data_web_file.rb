require './forex_data_file_downloader'
require './forex_data_file_utils'
require './forex_data_folder'

class ForexDataWebFile
    attr_accessor :forex_data_time, :file_name
    
    @@web_file_name_regexp = Regexp.new(%r{^(\d{2})(\d{2})(\d{2})\.zip$})
    
    def initialize(web_file_name)
        if web_file_name =~ @@web_file_name_regexp
            year_str = "20" + $3
            month_str = $2
            day_str = $1
            @forex_data_time = Time.gm(year_str.to_i, month_str.to_i, day_str.to_i)
            @web_file_name = web_file_name
            @url = "http://www.forexite.com/free_forex_quotes/" + year_str + "/" + month_str + "/" + @web_file_name
            @file_name = year_str + "_" + month_str + "_" + day_str + ".zip"
        end
    end
    
    def download(folder)
        file_path = folder.path + @file_name
        if !File.exists?(file_path)
            file_read = nil
            
            begin
                open(@url) do |data|
                    file_read = data.read
                end
            rescue => e
                p e.message + " " + @url 
            else
                open(file_path, 'wb') do |output|
                    output.write(file_read)
                end
            end
        end
    end
end