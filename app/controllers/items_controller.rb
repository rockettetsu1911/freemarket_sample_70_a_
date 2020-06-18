class ItemsController < ApplicationController
  require 'payjp'

  before_action :item_look_for, only: :purchase
  before_action :move_to_login, only: [:new]

  def index
    @items = Item.all.last(3)
    @likes_count = Like.group(:item_id).count

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
    @item.pictures.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました。'
    else
      flash.now[:alert] = @item.errors.full_messages
      @item.pictures.new
      render :new
    end
  end

  def get_category_children
    @category_children_array = set_ancestry(params[:parent_id])
  end

  def get_category_grandchildren
    @category_grandchildren_array = set_ancestry(params[:child_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    @card = Card.find_by(user_id: current_user.id)
    if @card == nil
      redirect_to new_card_path
      flash[:noCard] = "Cardが登録されていませんので登録してください"
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)

      # 《＋α》 登録しているカード会社のブランドアイコンを表示するためのコードです。---------
      @card_brand = @card_information.brand      
      case @card_brand
      when "Visa"
        @card_src = "if-visa-2593666_86609.svg"
      when "JCB"
        @card_src = "jcbcard.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "American Express"
        @card_src = "americancard.png"
      when "Diners Club"
        @card_src = "diners_club.png"
      when "Discover"
        @card_src = "discover.png"
      end
      # ---------------------------------------------------------------
    end
  end

  def pay
    @item = Item.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      amount: @item.price, # Payjpに載る金額
      customer: card.customer_id, # 顧客ID
      currency: 'jpy'
    )
    @item.update(buyer: current_user.id)
    require 'date'
    @item.update(bought_at: Time.now )
    redirect_to done_item_path(@item.id)
    flash[:notice] = "購入が完了しました"
  end

  def done
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
    flash[:notice] = "商品の削除が完了しました。"
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :condition, :explanation, pictures_attributes: [:image])
    .merge(user_id: current_user.id, category_id: params[:item][:category_id])
  end
  
  def set_categories
    @category_parent_array = @item.set_ancestry('parent', nil)
    params.require(:item).permit(:name, :price, :condition, :explanation, :category_id, pictures_attributes: [:image])
    .merge(user_id: current_user.id)
  end

  def set_ancestry(key)
    return Category.find(key).children
  end

  def move_to_login
    redirect_to user_session_path unless user_signed_in?
  end
  
  def item_look_for
    @item = Item.find(params[:id])
    unless @item.bought_at == nil
      redirect_to item_path(@item.id)
      flash[:notice] = "この商品は売り切れです。"
    end
  end

end
