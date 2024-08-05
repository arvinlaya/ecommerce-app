class ProductController < ApplicationController
  def create
  end

  def create_product
    permitted_params = params.permit(:name, :description, :price)

    product_data = {
      name: permitted_params[:name],
      description: permitted_params[:description],
      price: permitted_params[:price]
    }

    product = Product.new(product_data)

    result = {
      success: product.save,
      errors: product.errors.full_messages
    }

    render json: { result: result }  
  end
end
