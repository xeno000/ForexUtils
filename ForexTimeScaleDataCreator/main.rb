require './time_utils'
require './forex_time_scale'
require './time_range_array_factory'
require './time_range'
require '../ForexDataFilesToSQLite/forex_db'
require './forex_time_scale_data_record_array_factory'
require './forex_time_scale_db'

require './forex_time_scale_rawdata'

require 'benchmark'

# 指定した通貨、時間足、範囲で時間足DBを作成
# ruby -rrubygems main.rb USDJPY 15M 200701010000 201411010000

currency_pair = ARGV[0] # USDJPY EURUSD
time_scale_s = ARGV[1] # 15M 1H 4H 1D
start_s = ARGV[2] # 200701010000
end_s = ARGV[3] # 201411010000
#forex_db_range_string = ARGV[4] # 2007_2014 ForexDbのテーブル名に使用

start_time = TimeUtils.create_time_obj(start_s)
end_time = TimeUtils.create_time_obj(end_s)
time_scale = ForexTimeScale.new(time_scale_s)
time_range_array = Array.new

result = Benchmark.realtime do
    time_range_array = TimeRangeArrayFactory.create_array(start_time.to_i, end_time.to_i, time_scale)
end

p "TimeRangeArrayFactory.create_array() #{result}s"

db = ForexDb.new(currency_pair)
time_scale_db = ForexTimeScaleDb.new(currency_pair, time_scale)

chunk_size = 100000
i = 0
total = 0
chunk_array = Array.new

time_range_store = Array.new

time_range_array.each do |time_range|
=begin
    time_range_store.push(time_range)
    if chunk_size < time_range_store.count*time_scale.minute
        total += 1
        forex_time_scale_rawdata_array = db.select_time_range_array(time_range_store)
        forex_time_scale_data_record_array = ForexTimeScaleDataRecordArrayFactory.create_array_from_rawdata_array(forex_time_scale_rawdata_array)
        time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
        time_range_store = Array.new
        p total
    end
=end
    
    time_range_store.push(time_range)
    if chunk_size < time_range_store.count
        total += 1
        forex_time_scale_data_record_array = Array.new
        
        result = Benchmark.realtime do
            forex_time_scale_data_record_array = db.select_forex_time_scale_data_record_array(time_range_store)
        end
        
        p "db.select_forex_time_scale_data_record_array() #{result}s"
        
        result = Benchmark.realtime do
            time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
        end
        
        p "time_scale_db.insert_forex_time_scale_data_record_array() #{result}s"
        
        time_range_store = Array.new
        p total
    end
end


=begin
if  0 < time_range_store.count
    forex_time_scale_rawdata_array = db.select_time_range_array(time_range_store)
    forex_time_scale_data_record_array = ForexTimeScaleDataRecordArrayFactory.create_array_from_rawdata_array(forex_time_scale_rawdata_array)
    time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
end
=end

if  0 < time_range_store.count
    forex_time_scale_data_record_array = db.select_forex_time_scale_data_record_array(time_range_store)
    time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
end




p currency_pair + " " + time_scale_s + " " + start_s + " " + end_s