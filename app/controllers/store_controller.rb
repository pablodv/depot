class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    count_session
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    flash[:notice] = "Invalid product"
    redirect_to :action => "index"    
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index("Your cart is currenly empty")
  end
  
private 

  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => 'index'
  end
  
  def count_session
      session[:counter] ||= 0
      session[:counter] += 1
  end
  
end
