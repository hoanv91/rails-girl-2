class CartItemsController < ApplicationController
  # before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # # GET /cart_items
  # # GET /cart_items.json
  # def index
  #   @cart_items = CartItem.all
  # end

  # # GET /cart_items/1
  # # GET /cart_items/1.json
  # def show
  # end

  # # GET /cart_items/new
  # def new
  #   @cart_item = CartItem.new
  # end

  # # GET /cart_items/1/edit
  # def edit
  # end

  # # POST /cart_items
  # # POST /cart_items.json
  # def create
  #   @cart_item = CartItem.new(cart_item_params)

  #   respond_to do |format|
  #     if @cart_item.save
  #       format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
  #       format.json { render :show, status: :created, location: @cart_item }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @cart_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /cart_items/1
  # # PATCH/PUT /cart_items/1.json
  # def update
  #   respond_to do |format|
  #     if @cart_item.update(cart_item_params)
  #       format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @cart_item }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @cart_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /cart_items/1
  # # DELETE /cart_items/1.json
  # def destroy
  #   @cart_item.destroy
  #   respond_to do |format|
  #     format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_cart_item
  #     @cart_item = CartItem.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def cart_item_params
  #     params.require(:cart_item).permit(:product_id, :cart_id, :quantity)
  #   end
  # skip_before_action :verify_authenticity_token
  def create
    # Find associated product and current cart
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product)
    respond_to do |format|
      if @cart_item.save!
        if params[:add_to_cart].present?
          
        end
        format.html { redirect_back(fallback_location: @current_cart) }
        format.js
      else
        format.html { render :new, notice: 'Error adding product to basket!' }
      end
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_back(fallback_location: @current_cart)
  end

  # def add_quantity
  #   @cart_item = CartItem.find(params[:id])
  #   @cart_item.quantity += 1
  #   @cart_item.save
  #   redirect_back(fallback_location: @current_cart)
  # end

  # def reduce_quantity
  #   @cart_item = CartItem.find(params[:id])
  #   if @cart_item.quantity > 1
  #     @cart_item.quantity -= 1
  #     @cart_item.save
  #     redirect_back(fallback_location: @current_cart)
  #   elsif @cart_item.quantity == 1
  #     destroy
  #   end
  # end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
  end

  def add_items_to_cart(chosen_product)
    # If cart already has this product then find the relevant cart_item
    # and iterate quantity otherwise create a new cart_item for this product
    if @current_cart.products.include?(chosen_product)
      # Find the cart_item with the chosen_product
      @cart_item = @current_cart.cart_items.find_by(product_id: chosen_product)
      # Iterate the cart_item's quantity by one
      @cart_item.quantity += 1
    else
      @cart_item = CartItem.new
      @cart_item.cart = @current_cart
      @cart_item.product = chosen_product
      # @cart_item.order = Order.first
      @cart_item.quantity = params[:quantity].to_i || 1
    end
  end
end
