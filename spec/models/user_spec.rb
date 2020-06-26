require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is an instance of User class' do
    expect(User.new).to be_kind_of User
  end

  it 'has to have an email and password' do
    user = User.new(email: 'tester@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is not valid without a password' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    User.create(email: 'tester@example.com', password: 'password')
    user = User.new(email: 'tester@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'is invalid with wrong email format' do
    user = User.new(email: 'test')
    user.valid?
    expect(user.errors[:email]).to include('is invalid')
  end

  it 'is invalid with a password shorter than 6 characters' do
    user = User.new(password: '123')
    user.valid?
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end
end