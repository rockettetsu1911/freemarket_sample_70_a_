module TagsHelper
  def render_with_tag(items)
    item_names = []
    items.each do |item|
      item_names << item.name
    end
    return item_names
  end 
end
