class ForexDbTableUtils
    def self.create_table_sql(table_name)
        sql = <<-SQL 
        CREATE TABLE IF NOT EXISTS #{table_name} (
            time_id TIMESTAMP NOT NULL PRIMARY KEY,
            currency_pair TEXT NOT NULL,
            open REAL NOT NULL,
            high REAL NOT NULL,
            low REAL NOT NULL,
            close REAL NOT NULL
        );
        SQL
    end
    
    def self.create_table_name(currency_pair)
        currency_pair + "_" + "1_minute"
    end
end