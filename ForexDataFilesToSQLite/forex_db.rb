require 'sqlite3'
require File.dirname(__FILE__)  + '/forex_db_table_utils'
require File.dirname(__FILE__)  + '/forex_data_record'

class ForexDb 
    def initialize(currency_pair, range_string)
        @db_file_name = "forex.db"
        @db_file_path = File.dirname(__FILE__) + "/" + @db_file_name
        @table_name = ForexDbTableUtils.create_table_name(currency_pair, range_string)
    end
    
    def connect
        SQLite3::Database.new(@db_file_path)
    end
    
    def set_table
        db = connect
        db.execute(ForexDbTableUtils.create_table_sql(@table_name))
        db.close
    end
    
    def insert_forex_data_record_array(array)
        db = connect
        db.transaction do
            array.each do |record|
                db.execute("insert into #{@table_name} ( time_id, currency_pair, open, high, low, close) values (?,?,?,?,?,?)", record.time_id, record.currency_pair, record.open, record.high, record.low, record.close)
            end
        end
        db.close
    end
    
    def select_timestamp_range(start_timestamp, end_timestamp)
        record_array = Array.new
        db = connect
        db.results_as_hash = true
        db.execute("select * from #{@table_name} where time_id >= #{start_timestamp} and time_id <= #{end_timestamp}") do |row|
            record = ForexDataRecord.create_record_from_db_row(row)
            record_array.push(record)
        end
        record_array
    end
    
    def all
        db = connect
        db.execute("select * from #{@table_name}") do |row|
            p row
        end
        db.close
    end
end
        