require './forex_data_file'
require './forex_data_record_array_factory'
require './forex_db'
require '../ForexDataCrawler/forex_data_folder'
require './forex_1minute_data_creator'

#currency_pair_str = "USDJPY"
#data_range = "20140102_20140114"
#forex_data_file_folder_name = "test_2007_2014-20141104_045903"

# フォルダにあるデータファイル(Zip)全て使って、指定した通貨の1分足DBを作成
# nohup ruby main.rb EURUSD,USDJPY,USDCHF 2007_2014 &
currency_pair_str_array = ARGV[0].split(",")
#data_range = ARGV[1] # テーブル名に使用
forex_data_file_folder_name = ARGV[1] # ForexのZipファイルがあるフォルダ名

#forex_db = ForexDb.new(currency_pair_str)
#forex_db.set_table

folder = ForexDataFolder.read(forex_data_file_folder_name)

currency_pair_str_array.each do |currency_pair_str|
    creator = Forex1MinuteDataCreator.new(currency_pair_str, folder)
    creator.create
end 

=begin
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
    forex_data_line_array = forex_file.select_forex_data_line_array(currency_pair_str)

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
=end