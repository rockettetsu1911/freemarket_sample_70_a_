class ItemsController < ApplicationController

  def index
    @items = Item.all.last(3)
    @likes = Like.group(:item_id).count

    ctgry_ids = Category.roots.pluck(:id)
    items_by_category = {}
    ctgry_ids.each do |ctgry_id|
      category_items_id = Category.find(ctgry_id).descendant_ids
      items_by_category[:"#{Category.find(ctgry_id).name}"] = Item.where(category_id: category_items_id).last(3)
    end

    @picked_up_category = "レディース"
    @picked_up_items = items_by_category[:"#{@picked_up_category}"]

  end

  def new
    @item = Item.new
  end

end
