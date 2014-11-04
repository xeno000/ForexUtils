require './forex_data_file'
require './forex_data_record_array_factory'
require './forex_db'
require '../ForexDataCrawler/forex_data_folder'

#currency_pair = "USDJPY"
#data_range = "20140102_20140114"
#forex_data_file_folder_name = "test_2007_2014-20141104_045903"
currency_pair = ARGV[0]
data_range = ARGV[1]
forex_data_file_folder_name = ARGV[2]

forex_db = ForexDb.new(currency_pair, data_range)
forex_db.set_table

folder = ForexDataFolder.read(forex_data_file_folder_name)

folder.all_files.each do |path|
    p "path " + path
    
    forex_file = ForexDataFile.new(path)
    forex_file.read
    forex_data_line_array = forex_file.select_forex_data_line_array(currency_pair)

    record_array = ForexDataRecordArrayFactory.create_array_from_forex_data_line_array(forex_data_line_array)
    forex_db.insert_forex_data_record_array(record_array)
end



=begin
forex_file = ForexDataFile.new("../ForexDataCrawler/ForexiteZip/test_2007_2014-20141104_045903/2014_01_02.zip")
forex_file.read
forex_data_line_array = forex_file.select_forex_data_line_array("USDJPY")

record_array = ForexDataRecordArrayFactory.create_array_from_forex_data_line_array(forex_data_line_array)
forex_db.insert_forex_data_record_array(record_array)
=end

