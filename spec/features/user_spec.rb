require 'rails_helper'

feature 'User management' do
  before :each do
    create(:user)
    visit root_path
  end

  scenario 'adds a new user' do
    expect {
      click_link 'Sign up'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'user1'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'logs in an existing user' do
    sign_in :user
    expect(page).to  have_current_path(root_path)
    expect(page).to have_content 'user'
    expect(page).to have_content 'Signed in successfully.'
  end
end
