

class DirectoryTree 


  def initialize(shell, style, dir)
    @tree = Swt::Widgets::Tree.new(shell, style)

  end

  def method_missing(method, *args, &block)
    @tree.send(method, *args)
  end

  def widget
    @tree
  end

end