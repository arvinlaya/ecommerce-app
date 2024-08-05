require 'rails_helper'

RSpec.describe CartItem, type: :model do

  it "successfuly creates the record" do
    user = User.create(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    product = Product.create(
      name: "Product Name",
      description: "Product Description",
      price: 100
    )

    cart_item = CartItem.new(
      user: user,
      product: product
    )

    cart_item.save

    expect(CartItem.count).to be(1)
  end

  it "triggers user_id column validation" do
    product = Product.create(
      name: "Product Name",
      description: "Product Description",
      price: 100
    )

    cart_item = CartItem.new(
      user: nil,
      product: product
    )

    cart_item.save

    expect(cart_item.errors[:user].any?).to be(true)
  end

  it "triggers product_id column validation" do
    user = User.create(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    cart_item = CartItem.new(
      user: user,
      product: nil
    )

    cart_item.save

    expect(cart_item.errors[:product].any?).to be(true)
  end
end
