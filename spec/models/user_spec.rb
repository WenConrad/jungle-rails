require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should save sucessfully" do
      @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end
    it "should validate name" do
      @user = User.new({:name => nil, :email => "email", :password => "password", :password_confirmation => "password"})
      @user.save
      expect(@user.errors.full_messages).to include "Name can't be blank"
    end
    describe "should validate email" do
      it "should check email not nil" do
        @user = User.new({:name => "name", :email => nil, :password => "password", :password_confirmation => "password"})
        @user.save
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "should check if email exists" do
        @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
        @user.save!
        @user2 = User.new({:name => "name", :email => "EMAIL", :password => "password", :password_confirmation => "password"})
        @user2.save
        expect(@user2.errors.full_messages).to include "Email has already been taken"
      end
    end
    describe "should validate password" do
      it "should check password exists" do
        @user = User.new({:name => "name", :email => "email", :password => nil, :password_confirmation => nil})
        @user.save
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "should check password matches" do
        @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "passnotword"})
        @user.save
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "should check password length" do
        @user = User.new({:name => "name", :email => "email", :password => "pw", :password_confirmation => "pw"})
        @user.save
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
      end
    end
  end
  describe '.authenticate_with_credentials' do
    it "should pass if email and password matches" do
      @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
      @user.save!
      expect(User.authenticate_with_credentials("email", "password")).to eq(@user)
    end
    it "should check whitespaces" do
      @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
      @user.save!
      expect(User.authenticate_with_credentials(" email ", "password")).to eq(@user)
    end
    it "should be case insensitive for email" do
      @user = User.new({:name => "name", :email => "email", :password => "password", :password_confirmation => "password"})
      @user.save!
      expect(User.authenticate_with_credentials("emAiL", "password")).to eq(@user)
    end
  end
end