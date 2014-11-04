require 'open-uri'
require './forex_data_folder'
require './forex_data_file_utils'

class ForexDataFileDownLoader
    def self.download(url, folder)
        file_path = folder.path + ForexDataFileUtils.create_file_name_from_url(url)
        open(url) do |data|
            @file_read = data.read
        end
         
        open(file_path, 'wb') do |output|
            output.write(@file_read)
        end
    end
end