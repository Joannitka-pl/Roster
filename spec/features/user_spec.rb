require 'rails_helper'
require 'pry'

feature 'User management' do
  before :each do
    visit root_path
  end

  let(:user) { create(:user) }

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
    login user
    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'logs out existing user' do
    login user
    click_link 'Logout'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'edits email of logged in user' do
    login user
    click_link 'Edit profile'
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content 'Edit User'
    fill_in 'Email', with: 'user_changed@example.com'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'edits password of logged in user' do
    login user
    click_link 'Edit profile'
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content 'Edit User'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'changed_password'
    fill_in 'Password confirmation', with: 'changed_password'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'remembers user login with rember me option' do
    login_with_remember_me user
    expire_cookies
    Timecop.freeze(Date.today + 14) do
      visit '/'
      expect(page).to have_link 'Logout'
    end
  end

  scenario 'forgets user after 2 weeks from login with remember me option' do
    login_with_remember_me user
    expire_cookies

    Timecop.freeze(Date.today + 15) do
      visit '/'
      expect(page).to have_button 'Log in'
    end
  end

  scenario 'forgets user after close browser without remember me option' do
    login user
    expire_cookies
    visit '/'
    expect(page).to have_button 'Log in'
  end

  scenario 'deletes user' do
    login user
    click_link 'Edit profile'
    click_button 'Cancel my account'
    expect(current_path).to eq new_user_session_path
  end
end
