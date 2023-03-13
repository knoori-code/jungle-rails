require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save successfully with all four fields set' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 9.99, quantity: 5, category: @category)
      expect(@product).to be_valid
    end

    it 'should not be valid without a name' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(name: nil, price: 9.99, quantity: 5, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not be valid without a price' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 9.99, quantity: 5, category: @category)
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it 'should not be valid without a quantity' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 9.99, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not be valid without a category' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 9.99, quantity: 5, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

