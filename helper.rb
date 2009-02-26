class Helper
  
  def link href = '#', content = href, &block
    if block_given?
      "<a href='#{href}'>#{capture &block}</a>"
    else
      "<a href='#{href}'>#{content}</a>"
    end
  end
  
end