class HomeController < ApplicationController
  before_action :require_sign_in
  def index
    @products = Product.all
  end

  def cart_items
    @products = @user.products
  end

  def delete_cart_item
    permitted_params = params.permit(:productId)
    product = Product.find(permitted_params[:productId])

    cart_item = CartItem.find_by(user: @user, product: product)

    result = {
      success: !!cart_item.destroy,
      errors: cart_item.errors.full_messages
    }

    render json: { result: result }
  end
end
