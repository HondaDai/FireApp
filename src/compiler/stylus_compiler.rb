
require 'stylus'
require 'pathname'

class StylusCompiler < BaseCompiler

  def self.src_file_ext
    "styl"
  end

  def self.dst_file_ext
    "css"
  end

  def self.cache_folder_name
    ".stylus-cache"
  end

  def self.compile(src_file_path, dst_file_path, options = {})

    self._compile(src_file_path, dst_file_path, options) do 
      Stylus.compile Pathname.new(src_file_path).read #, options
    end

  end

end