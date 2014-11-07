require './time_utils'
require './forex_time_scale'
require './time_range_array_factory'
require './time_range'
require '../ForexDataFilesToSQLite/forex_db'
require './forex_time_scale_data_record_array_factory'
require './forex_time_scale_db'

require './forex_time_scale_rawdata'

# 指定した通貨、時間足、範囲で時間足DBを作成

currency_pair = ARGV[0] # USDJPY EURUSD
time_scale_s = ARGV[1] # 15M 1H 4H 1D
start_s = ARGV[2] # 200701010000
end_s = ARGV[3] # 201411010000
forex_db_range_string = ARGV[4] # 2007_2014 ForexDbのテーブル名に使用

start_time = TimeUtils.create_time_obj(start_s)
end_time = TimeUtils.create_time_obj(end_s)
time_scale = ForexTimeScale.new(time_scale_s)
time_range_array = TimeRangeArrayFactory.create_array(start_time.to_i, end_time.to_i, time_scale)

db = ForexDb.new(currency_pair, forex_db_range_string)
time_scale_db = ForexTimeScaleDb.new(currency_pair, time_scale)

chunk_size = 10
i = 0
total = 0
chunk_array = Array.new

time_range_store = Array.new

time_range_array.each do |time_range|
    time_range_store.push(time_range)
    if chunk_size == time_range_store.count
        total += 1
        forex_time_scale_rawdata_array = db.select_time_range_array(time_range_store)
        forex_time_scale_data_record_array = ForexTimeScaleDataRecordArrayFactory.create_array_from_rawdata_array(forex_time_scale_rawdata_array)
        time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
        time_range_store = Array.new
        p total
    end
    
=begin
    record_array = db.select_timestamp_range(time_range.range_start, time_range.range_end)
    
    if record_array.count != 0
        i += 1
        total += 1
        forex_time_scale_data_record = ForexTimeScaleDataRecord.create_record_from_forex_data_record_array(record_array)
        chunk_array.push(forex_time_scale_data_record)
        if chunk_size == i
            time_scale_db.insert_forex_time_scale_data_record_array(chunk_array)
            i = 0
            chunk_array = Array.new
            p total
        end
    end
=end

end

if  0 < time_range_store.count
    forex_time_scale_rawdata_array = db.select_time_range_array(time_range_store)
    forex_time_scale_data_record_array = ForexTimeScaleDataRecordArrayFactory.create_array_from_rawdata_array(forex_time_scale_rawdata_array)
    time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
end


#if chunk_array.count != 0
#    time_scale_db.insert_forex_time_scale_data_record_array(chunk_array)
#end

p currency_pair + " " + time_scale_s + " " + start_s + " " + end_s + " " + forex_db_range_string