require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should save sucessfully" do
      @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
      expect{@user.save!}.to_not raise_error()
    end
    it "should validate name" do
      @user = User.new({:name => nil, :email => "email", :password => "password", :password_confirmation => "password"})
      expect{@user.save!}.to raise_error()
    end
    describe "should validate email" do
      it "should check email not nil" do
        @user = User.new({:name => "name", :email => nil, :password => "password", :password_confirmation => "password"})
        expect{@user.save!}.to raise_error()
      end
      it "should check if email exists" do
        @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
        @user.save!
        @user2 = User.new({:name => "name", :email => "EMAIL", :password => "password", :password_confirmation => "password"})
        expect{@user2.save!}.to raise_error()
      end
    end
    describe "should validate password" do
      it "should check password exists" do
        @user = User.new({:name => "name", :email => "email", :password => nil, :password_confirmation => nil})
        expect{@user.save!}.to raise_error()
      end
      it "should check password matches" do
        @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "passnotword"})
        expect{@user.save!}.to raise_error()
      end
      it "should check password length" do
        @user = User.new({:name => "name", :email => "email", :password => "pw", :password_confirmation => "pw"})
        expect{@user.save!}.to raise_error()
      end
    end
  end
end
