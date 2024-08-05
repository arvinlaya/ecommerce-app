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
      success: !!product.save,
      errors: product.errors.full_messages
    }

    render json: { result: result }
  end

  def edit
    permitted_params = params.permit(:product_id)
    @product = Product.find(permitted_params[:product_id])
  end

  def edit_product
    permitted_params = params.permit(:name, :description, :price, :productId)

    product_data = {
      name: permitted_params[:name],
      description: permitted_params[:description],
      price: permitted_params[:price]
    }

    product = Product.find(permitted_params[:productId])

    result = {
      success: !!product.update(product_data),
      errors: product.errors.full_messages
    }

    render json: { result: result }
  end

  def delete_product
    permitted_params = params.permit(:productId)
    product = Product.find(permitted_params[:productId])

    result = {
      success: !!product.destroy,
      errors: product.errors.full_messages
    }

    render json: { result: result }
  end
end
