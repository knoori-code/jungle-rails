require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    subject {
      described_class.new(first_name: 'Test', last_name: 'User', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a short password' do
      subject.password = 'pass'
      subject.password_confirmation = 'pass'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a different password and confirmation' do
      subject.password_confirmation = 'different'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      subject.save
      duplicate = described_class.new(first_name: 'Test', last_name: 'User', email: 'TEST@test.com', password: 'password', password_confirmation: 'password')
      expect(duplicate).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    subject {
      described_class.new(first_name: 'Test', last_name: 'User', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    }

    it 'returns the user if authenticated successfully' do
      subject.save
      user = described_class.authenticate_with_credentials('test@test.com', 'password')
      expect(user).to eq(subject)
    end
  end
end
