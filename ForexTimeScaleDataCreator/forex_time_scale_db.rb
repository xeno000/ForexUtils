require './forex_time_scale_db_utils'
require './forex_time_scale_data_record'

class ForexTimeScaleDb
    def initialize(currency_pair, time_scale)
        @db_file_name = "forex_time_scale.sqlite"
        @db_file_path = File.dirname(__FILE__) + "/" + @db_file_name
        @table_name = ForexTimeScaleDbUtils.create_table_name(currency_pair, time_scale)
        set_table
    end
    
    def connect
        SQLite3::Database.new(@db_file_path)
    end
    
    def set_table
        db = connect
        db.execute(ForexTimeScaleDbUtils.create_table_sql(@table_name))
        db.close
    end
    
    def insert_forex_time_scale_data_record_array(record_array)
        db = connect
        db.transaction do
            record_array.each do |record|
                db.execute("insert or ignore into #{@table_name} ( open_minute_open_timestamp, open, high, low, close, close_minute_close_timestamp) values (?,?,?,?,?,?)", record.open_minute_open_timestamp, record.open, record.high, record.low, record.close, record.close_minute_close_timestamp)
            end 
        end
        db.close
    end
end