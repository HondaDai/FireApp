
require 'pathname'

class DirectoryTree 


  def initialize(shell, style, dir)
    @tree = Swt::Widgets::Tree.new(shell, style | Swt::SWT::SINGLE)
    @dir = Pathname.new(dir)
    @mapping = Hash.new

    @tree.addListener(Swt::SWT::Selection, Swt::Widgets::Listener.impl do |method, evt|  
      @selected = @mapping[evt.item]
      puts @selected
    end)

    @tree.addListener(Swt::SWT::Expand, Swt::Widgets::Listener.impl do |method, evt|
      puts "Expand"

      fold_dir(evt.item)
      unfold_dir(@mapping[evt.item], evt.item)
      puts @mapping.size
    end)

    unfold_dir(@dir, @tree)
  end

  def selected
    @selected
  end

  def fold_dir(parent_node)

    (0..parent_node.getItemCount-1).each do |i|
      item = parent_node.getItem(i)
      fold_dir(item)
      @mapping.delete(item)
      parent_node.clear(i, true)
    end
    parent_node.clearAll(true)
    parent_node.removeAll

  end

  def unfold_dir(parent_dir, parent_node)

    if parent_dir.directory?

      directory_offset = 0
      file_offset = 0

      parent_dir.children.each do |d|

        next if d.basename.to_s =~ /^\./

        if d.directory?
          offset = directory_offset
          directory_offset = directory_offset+1
        else
          offset = directory_offset + file_offset
          file_offset = file_offset+1
        end

        puts offset

        item = Swt::Widgets::TreeItem.new(parent_node, Swt::SWT::NONE, offset)
        item.setText(d.basename.to_s)

        @mapping[item] = d

        Swt::Widgets::TreeItem.new(item, Swt::SWT::NONE) if d.directory?
=begin
        item.addListener(Swt::SWT::Selection, Swt::Widgets::Listener.impl do |method, evt|  
          @selected = d
          puts @selected
        end)

        if d.directory?
          Swt::Widgets::TreeItem.new(item, Swt::SWT::NONE)
          item.addListener(Swt::SWT::Expand, Swt::Widgets::Listener.impl do |method, evt|
            puts "Expand"
            item.clearAll
            unfold_dir(d, item)
          end)
          item.addListener(Swt::SWT::Collapse, Swt::Widgets::Listener.impl do |method, evt|
            puts "Collapse"
            item.clearAll
          end)
        end
=end



      end
    end
  end

  def method_missing(method, *args, &block)
    @tree.send(method, *args)
  end

  def widget
    @tree
  end

end