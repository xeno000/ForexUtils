require './forex_data_file'
require './forex_data_record_array_factory'
require './forex_db'
require '../ForexDataCrawler/forex_data_folder'

#currency_pair = "USDJPY"
#data_range = "20140102_20140114"
#forex_data_file_folder_name = "test_2007_2014-20141104_045903"

# フォルダにあるデータファイル(Zip)全て使って、指定した通貨の1分足DBを作成

currency_pair = ARGV[0]
#data_range = ARGV[1] # テーブル名に使用
forex_data_file_folder_name = ARGV[1] # ForexのZipファイルがあるフォルダ名

forex_db = ForexDb.new(currency_pair)
forex_db.set_table

folder = ForexDataFolder.read(forex_data_file_folder_name)

chunk_size = 300
i = 0
total = 0
chunk_array = Array.new

folder.all_files.each do |path|
    i += 1
    total += 1
    #p  i.to_s + " " + total.to_s + " path " + path
    
    forex_file = ForexDataFile.new(path)
    forex_file.read
    forex_data_line_array = forex_file.select_forex_data_line_array(currency_pair)

    record_array = ForexDataRecordArrayFactory.create_array_from_forex_data_line_array(forex_data_line_array)
    chunk_array.concat(record_array)
    
    if i==chunk_size
        p  i.to_s + " " + total.to_s
        forex_db.insert_forex_data_record_array(chunk_array)
        i = 0
        chunk_array = Array.new
    end
end

p  i.to_s + " " + total.to_s
forex_db.insert_forex_data_record_array(chunk_array)