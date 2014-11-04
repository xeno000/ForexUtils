class ForexDataFolderUtils
    
    @@default_folder_name = "ForexiteZip"
    
    def self.create_name(folder_name)
        folder_name = folder_name + "-" + Time.now.strftime("%Y%m%d_%H%M%S")
    end
    
    def self.create_path(folder_name)
        path = File.dirname(__FILE__) + "/" + @@default_folder_name + "/" + folder_name + "/"
    end
  
end