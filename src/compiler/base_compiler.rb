

class BaseCompiler

  def self.log(type, msg)
    msg = msg.sub(File.expand_path(Compass.configuration.project_path), '')[1..-1] if defined?(Tray) 

    if defined?(Tray) && Tray.instance.logger
      Tray.instance.logger.record type, msg
    else  
      puts "   #{type} #{msg}"
    end
  end

  def self.compile(src_file_path, dst_file_path, options)
    src_file_path = Pathname.new(src_file_path)
    dst_file_path = Pathname.new(dst_file_path)

    raise "You should implement this method: #{__method__}"
  end

  def self.ext
    # "*.coffee"
    raise "You should implement this method: #{__method__}"
  end

  def self.cache_folder_name
    # "*.coffeescript-cache"
    raise "You should implement this method: #{__method__}"
  end


  def self.compile_folder(src_dir, dst_dir, options = {})
    src_dir = File.expand_path(src_dir)
    dst_dir = File.expand_path(dst_dir)
    src_files = File.join(src_dir, "**", self.ext)


    Dir.glob( src_files ) do |path|
      #new_js_path = dst_file_path(src_dir, path, dst_dir)

      # CoffeeCompiler.new(full_path, new_js_path, get_cache_dir(coffeescripts_dir), options ).compile
      compile(
        path, 
        dst_file_path(src_dir, path, dst_dir),
        options
      )

    end
  end

  def self.cache_dir
    if not defined?(App)
      raise "You shoulod have App"
    end

    dir = File.expand_path( File.join(Compass.configuration.project_path, self.cache_folder_name))
    FileUtils.mkdir_p(dir) unless  File.exists?(dir)
    return dir

  end

  def self.dst_file_path(src_dir, src_file_path, dst_dir)

  end

  def self.clean_folder(src_dir, dst_dir)
    src_dir = File.expand_path(src_dir)
    dst_dir = File.expand_path(dst_dir)
  end


end