require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should save sucessfully" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => 123, :quantity => 123, :category => @category})
      @product.save
      expect(@product.errors.full_messages).to be_empty
    end
    it "should validate name" do
      @category = Category.new()
      @product = Product.new({:name => nil, :price => 123, :quantity => 123, :category => @category})
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it "should validate price" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => nil, :quantity => 123, :category => @category})
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it "should validate quantity" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => 123, :quantity => nil, :category => @category})
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it "should validate category" do
      @product = Product.new({:name => "name", :price => 123, :quantity => 123, :category => nil})
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end