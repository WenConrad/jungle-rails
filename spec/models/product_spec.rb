require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should save sucessfully" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => 123, :quantity => 123, :category => @category})
      expect{@product.save!}.to_not raise_error()
    end
    it "should validate name" do
      @category = Category.new()
      @product = Product.new({:name => nil, :price => 123, :quantity => 123, :category => @category})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should validate price" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => nil, :quantity => 123, :category => @category})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should validate quantity" do
      @category = Category.new()
      @product = Product.new({:name => "name", :price => 123, :quantity => nil, :category => @category})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should validate category" do
      @product = Product.new({:name => "name", :price => 123, :quantity => 123, :category => nil})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end