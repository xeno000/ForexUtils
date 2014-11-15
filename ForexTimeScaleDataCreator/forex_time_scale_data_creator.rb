class ForexTimeScaleDataCreator
    def initialize(currency_pair, time_scale)
        @db = ForexDb.new(currency_pair)
        @time_scale_db = ForexTimeScaleDb.new(currency_pair, time_scale)
    end

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