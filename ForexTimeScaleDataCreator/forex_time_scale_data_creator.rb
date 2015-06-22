class ForexTimeScaleDataCreator
    def initialize(currency_pair, time_scale)
        @time_scale = time_scale
        @db = ForexDb.new(currency_pair)
        @time_scale_db = ForexTimeScaleDb.new(currency_pair, time_scale)
    end
    
    def create(start_time, end_time)
        time_range_array = Array.new
        result = Benchmark.realtime do
            time_range_array = TimeRangeArrayFactory.create_array(start_time.to_i, end_time.to_i, @time_scale)
        end
        p "TimeRangeArrayFactory.create_array() #{result}s"
        
        chunk_size = 100000
        i = 0
        total = 0
        chunk_array = Array.new

        time_range_store = Array.new

        time_range_array.each do |time_range|
            time_range_store.push(time_range)
        
            if chunk_size < time_range_store.count
                total += 1
                create_forex_time_scale_data(time_range_store)
                time_range_store = Array.new
                p total
            end
        end

        if  0 < time_range_store.count
            create_forex_time_scale_data(time_range_store)
        end
    end 
    
    private
    
    def create_forex_time_scale_data(time_range_array)
        forex_time_scale_data_record_array = Array.new
        result = Benchmark.realtime do
            forex_time_scale_data_record_array = @db.select_forex_time_scale_data_record_array(time_range_array)
        end
        p "db.select_forex_time_scale_data_record_array() #{result}s"
        
        result = Benchmark.realtime do
            @time_scale_db.insert_forex_time_scale_data_record_array(forex_time_scale_data_record_array)
        end
        p "time_scale_db.insert_forex_time_scale_data_record_array() #{result}s"
    end  
end