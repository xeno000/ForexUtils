require 'fileutils'
require File.dirname(__FILE__)  + '/forex_data_folder_utils'

class ForexDataFolder
    
    @folder_name = String.new
    @path = String.new 

  def self.create(folder_name)
    folder_name = ForexDataFolderUtils.create_name(folder_name)
    path =  ForexDataFolderUtils.create_path(folder_name)
    FileUtils.mkdir_p(path.chop)
    
    folder = self.new
    folder.folder_name = folder_name
    folder.path = path
    folder
  end
  
  def self.read(folder_name)
    path = ForexDataFolderUtils.create_path(folder_name)
    if File.exists?(path)
      folder = self.new
      folder.folder_name = folder_name
      folder.path = path
      folder
    else
      folder = nil
    end
  end
  
  def all_files
    Dir.glob(@path + "*.zip").sort
  end
  
  attr_accessor :folder_name
  attr_accessor :path
  
end