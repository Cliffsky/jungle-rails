require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'must require a name' do
      category = Category.create(name: 'shoes')
      product = Product.new(name: nil, description: Faker::Company.bs,  price_cents: rand(1000000), quantity: rand(100), category_id: category.id)
      expect(product.save).to be(false)
    end

    it 'must require a price' do
      category = Category.create(name: 'face')
      product = Product.new(name: Faker::Company.name, description: Faker::Company.bs, price_cents: nil, quantity: rand(100), category_id: category.id)
      expect(product.save).to be(false)
    end

    it 'must require a quantity' do
      category = Category.create(name: 'fries')
      product = Product.new(name: Faker::Company.name, description: Faker::Company.bs,  price_cents: rand(1000000), quantity: nil, category_id: category.id)
      expect(product.save).to be(false)
    end

    it 'must require a category' do
      category = Category.create(name: 'romance')
      product = Product.new(name: Faker::Company.name, description: Faker::Company.bs,  price_cents: rand(1000000), quantity: rand(100), category_id: nil)
      expect(product.save).to be(false)
    end

    it 'must save a new product to the database when parameters are passed properly' do
      category = Category.create(name: 'ding dong')
      product = Product.new(name: Faker::Company.name, price_cents: rand(1000000), quantity: rand(100), category_id: category.id)
      expect(product.save).to be(true)
    end
  end
end
