class ItemsController < ApplicationController

  def index
    @items = Item.all.last(3)
    @likes = Like.group(:item_id).count
  end

  def new
    @item = Item.new
  end

end
