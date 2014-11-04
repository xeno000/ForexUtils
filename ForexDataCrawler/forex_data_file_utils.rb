class ForexDataFileUtils
    def self.create_file_name_from_url(url)
        file_name = String.new
        url.scan(%r{(\d{4})/(\d{2})/(\d{2})\d{4}\.zip}) do |year, month, day|
            file_name = year + "_" + month + "_" + day + ".zip" 
        end
        #@rawFileName = File.basename(url)
        #@rawFileName.scan(/(\d{2})(\d{2})(\d{2})/) do |d1, d2, d3|
        #    @fileName = d3 + "_" + d2 + "_" + d1 + ".zip" 
        #end
        file_name
    end
end