class ItemsController < ApplicationController
  require 'payjp'

  before_action :item_look_for, only: :purchase
  before_action :move_to_login, only: [:new, :edit]
  before_action :set_item, only: [:edit, :update]
  before_action :correct_user, only: :edit

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

    respond_to do |format|
      format.html
      format.json { render json: @items.concat(@picked_up_items)}
    end
  end

  def new
    @item = Item.new
    @item.pictures.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), notice: '出品が完了しました。'
    else
      flash.now[:alert] = @item.errors.full_messages
      @item.pictures.new
      set_category if @item.category != nil
      render :new
    end
  end

  def edit
    set_category
  end

  def update
    if params[:item].keys.include?('picture') || params[:item].keys.include?('pictures_attributes')
      before_pictures_ids = @item.pictures.ids
      if @item.update(item_params)
        if params[:item].keys.include?('picture')
          update_pictures_ids = params[:item][:picture].values
          before_pictures_ids.each do |pict_id|
            Picture.find(pict_id).destroy unless update_pictures_ids.include?("#{pict_id}")
          end
        else
          before_pictures_ids.each do |pict_id|
            Picture.find(pict_id).destroy
          end
        end
        redirect_to item_path(@item), notice: '商品を編集しました'
      else
        flash[:alert] = @item.errors.full_messages
        redirect_back(fallback_location: :edit)
      end
    else
      flash[:alert] = '画像は1枚以上必要です'
      redirect_back(fallback_location: root_path)
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
    respond_to do |format|
      format.html do
        @item.view_count += 1 unless user_signed_in? && current_user.id == @item.user.id
        @item.save
        render :show
      end
      format.json {render json: @item}
    end
  end

  def purchase
    @item = Item.find(params[:id])
    @card = Card.find_by(user_id: current_user.id)
    if @card == nil
      redirect_to new_card_path
      flash[:alert] = "クレジットカードが登録されていませんので登録してください"
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
    if item.destroy
      redirect_to root_path
      flash[:notice] = "商品の削除が完了しました。"
    else
      redirect_to item_path(item.id)
      flash[:notice] = "商品の削除に失敗しました。"
    end
  end
  
  def tag
    @tag = Tag.find_by(name: params[:name])
    @items = @tag.items
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :condition, :explanation, :view_count, pictures_attributes: [:image, :_destroy, :id])
    .merge(user_id: current_user.id, category_id: params[:item][:category], prefecture_id: params["prefecture"], postage_id: params["postage"], delivery_date_id: params["delivery-date"])
  end

  def set_ancestry(key)
    return Category.find(key).children
  end

  def move_to_login
    redirect_to user_session_path unless user_signed_in?
  end

  def correct_user
    redirect_to purchase_item_path unless current_user.id == @item.user_id
  end

  def set_category
    @category_grandchild = @item.category
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    @child_array = []
    @child_array = set_ancestry(@category_parent.id)
    @grandchild_array = []
    @grandchild_array = set_ancestry(@category_child.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_look_for
    @item = Item.find(params[:id])
    unless @item.bought_at == nil
      redirect_to item_path(@item.id)
      flash[:notice] = "この商品は売り切れです。"
    end
  end

end
