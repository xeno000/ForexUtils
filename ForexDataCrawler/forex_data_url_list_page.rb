class ForexDataUrlListPage

  def initialize(url)
    @url = url
  end
  
  def read
    open(@url) do |data|
      @file_read = data.read
    end
  end

  def select_forex_data_url_all
    url_list = Array.new 
    @file_read.scan(%r{<a href=\"(\d{4}/\d{2}/\d{6}\.zip)\">}) do |file_name|
        url_list.push("http://www.forexite.com/free_forex_quotes/" + file_name.first)
    end
    url_list
  end
  
end