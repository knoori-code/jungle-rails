require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should create a new user when all required fields are present' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: 'password', 
        password_confirmation: 'password'
      )
      expect(user.valid?).to be true
    end

    it 'should not create a new user when email is not present' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: nil, 
        password: 'password', 
        password_confirmation: 'password'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not create a new user when password is not present' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: nil, 
        password_confirmation: 'password'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not create a new user when password_confirmation is not present' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: 'password', 
        password_confirmation: nil
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not create a new user when password and password_confirmation do not match' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: 'password', 
        password_confirmation: 'different_password'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not create a new user when email is not unique (case-insensitive)' do
      user1 = User.create!(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: 'password', 
        password_confirmation: 'password'
      )
      user2 = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'TEST@email.com', 
        password: 'password', 
        password_confirmation: 'password'
      )
      expect(user2.valid?).to be false
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not create a new user when password is too short' do
      user = User.new(
        first_name: 'John', 
        last_name: 'Doe', 
        email: 'test@email.com', 
        password: 'pass', 
        password_confirmation: 'pass'
      )
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns the user if authenticated successfully' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@email.com', password: 'password', password_confirmation: 'password')
      user.save
      authenticated_user = User.authenticate_with_credentials('test@email.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates even if email is in the wrong case' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@email.com', password: 'password', password_confirmation: 'password')
      user.save
      authenticated_user = User.authenticate_with_credentials('TEST@EMAIL.COM', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates user even if email has leading/trailing white spaces' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@email.com', password: 'password', password_confirmation: 'password')
      user.save
  
      # Test with white spaces before email
      authenticated_user = User.authenticate_with_credentials('   test@email.com', 'password')
      expect(authenticated_user).to eq(user)
  
      # Test with white spaces after email
      authenticated_user = User.authenticate_with_credentials('test@email.com   ', 'password')
      expect(authenticated_user).to eq(user)
  
      # Test with spaces before and after email
      authenticated_user = User.authenticate_with_credentials('   test@email.com   ', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
