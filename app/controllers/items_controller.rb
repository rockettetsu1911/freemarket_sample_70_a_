class ItemsController < ApplicationController

  def index
    @items = Item.all.last(3)
  end

  def new
    @item = Item.new
  end

end
