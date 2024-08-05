require 'rails_helper'

RSpec.describe Product, type: :model do
  it "successfuly creates the record" do
    product = Product.new(
      name: "Product Name",
      description: "Product Description",
      price: 100
    )

    product.save

    expect(Product.count).to be(1)
  end

  it "successfuly updates the record" do
    product = Product.new(
      name: "Product Name",
      description: "Product Description",
      price: 100
    )

    product.save

    product.name = "New Product Name"
    product.description = "New Product Description"
    product.price = 200

    product.save

    expect(product).to have_attributes(
                   name: "New Product Name",
                   description: "New Product Description",
                   price: 200
                 )
  end

  it "successfully deletes the record" do
    product = Product.new(
      name: "Product Name",
      description: "Product Description",
      price: 100
    )

    product.save

    expect { product.destroy }.to change { Product.count }.by(-1)
  end

  it "triggers name column validation" do
    product = Product.new(
      name: "",
      description: "Product Description",
      price: 100
    )

    product.save

    expect(product.errors[:name].any?).to be(true)
  end

  it "triggers description column validation" do
    product = Product.new(
      name: "Product Name",
      description: "",
      price: 100
    )

    product.save

    expect(product.errors[:description].any?).to be(true)
  end

  it "triggers price column validation" do
    product = Product.new(
      name: "Product Name",
      description: "Product Description"
    )

    product.save

    expect(product.errors[:price].any?).to be(true)
  end
end
