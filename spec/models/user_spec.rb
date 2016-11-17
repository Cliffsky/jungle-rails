require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should insert a user when credentials are provided properly' do
      user = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      expect(user).to be_valid
    end

    it 'should not save if no name is provided' do
      user = User.new(name: nil, email: Faker::Internet.email, password:nil, password_confirmation:'abcdefgh')
      expect(user).to_not be_valid
    end

    it 'should not save if no email is provided' do
      user = User.new(name: Faker::Internet.user_name, email: nil, password:nil, password_confirmation:'abcdefgh')
      expect(user).to_not be_valid
    end

    it 'expects a password' do
      user = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:nil, password_confirmation:'abcdefgh')
      expect(user).to_not be_valid
    end

    it 'expects a password_confirmation' do
      user = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'')
      expect(user).to_not be_valid
    end

    it 'is valid when password and password_confirmation match' do
      user = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      expect(user).to be_valid
    end

    it 'is invalid when password and password_confirmation do not match' do
      user = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'bcdefgha')
      expect(user).to_not be_valid
    end

    it 'expects emails to be unique' do
      user1 = User.new(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      user2 = User.new(name: Faker::Internet.user_name, email: user1.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      user1.save
      expect(user2.save).to be(false)
    end

    it 'is case insensitive for emails' do
      user1 = User.new(name: Faker::Internet.user_name, email: 'nick@nick.com', password:'abcdefgh', password_confirmation:'abcdefgh')
      user2 = User.new(name: Faker::Internet.user_name, email: 'Nick@nick.com', password:'abcdefgh', password_confirmation:'abcdefgh')
      user1.save
      expect(user2.save).to be(false)
    end

    it 'requires user passwords to be 8 characters or more' do
      user = User.new(name: Faker::Internet.user_name, email: 'nick@nick.com', password:'a', password_confirmation:'a')
      expect(user).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it 'authenticates users when they provide the right credentials' do
      user = User.create(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      expect(User.authenticate_with_credentials(user.email, user.password) == user).to be(true)
    end

    it 'does not authenticate users when they provide the wrong email' do
      user = User.create(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      expect(User.authenticate_with_credentials(Faker::Internet.email, user.password) == user).to be(false)
    end

    it 'does not authenticate users when they provide the wrong email' do
      user = User.create(name: Faker::Internet.user_name, email: Faker::Internet.email, password:'abcdefgh', password_confirmation:'abcdefgh')
      expect(User.authenticate_with_credentials(user.email, 'password') == user).to be(false)
    end
  end

  describe "edge cases" do
    it 'strips whitespace in signup credentials' do
      user = User.create(name: "nick", email: "     n@n.com", password:'abcdefgh', password_confirmation:'abcdefgh')
      pp user
      expect(User.authenticate_with_credentials("n@n.com", 'abcdefgh') == user).to be(true)
    end
  end
end
