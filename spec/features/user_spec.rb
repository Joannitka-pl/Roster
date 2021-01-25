# frozen_string_literal: true

require 'rails_helper'

feature 'User management' do
  before :each do
    visit root_path
  end

  let(:user) { create(:user) }

  scenario 'adds a new user' do
    expect do
      click_link 'Enter'
      click_link 'Sign up'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
    end.to change(User, :count).by(1)
    expect(current_path).to eq my_roster_path

    within('header') do
      expect(page).to have_selector('strong', text: 'user1@example.com')
    end
    within('body') do
      expect(page).to have_selector('.alert-success', text: 'Welcome! You have signed up successfully.')
    end
  end

  scenario 'logs in an existing user' do
    login user
    expect(current_path).to eq root_path

    within('body') do
      expect(page).to have_selector('.alert-success', text: 'Signed in successfully.')
    end
  end

  scenario 'logs out existing user' do
    login user
    click_link 'Logout'
    expect(current_path).to eq root_path

    within('body') do
      expect(page).to have_selector('.alert-success', text: 'Signed out successfully')
    end
  end

  scenario 'edits email of logged in user' do
    login user
    click_link 'Edit profile'
    expect(current_path).to eq edit_user_registration_path

    within('body') do
      expect(page).to have_selector('h2', text: 'Edit User')
    end

    fill_in 'Email', with: 'user_changed@example.com'
    fill_in 'Current password', with: '123456'
    click_button 'Update'
    expect(current_path).to eq root_path

    within('body') do
      expect(page).to have_selector('.alert-success', text: 'Your account has been updated successfully.')
    end
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

    within('body') do
      expect(page).to have_selector('.alert-success', text: 'Your account has been updated successfully.')
    end
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
      expect(page).to have_link 'Enter'
    end
  end

  scenario 'forgets user after close browser without remember me option' do
    login user
    expire_cookies
    visit '/'
    expect(page).to have_link 'Enter'
  end

  scenario 'deletes user' do
    login user
    click_link 'Edit profile'
    click_button 'Cancel my account'
    expect(current_path).to eq root_path

    within('body') do
      expect(page).to have_selector('p', text: 'Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    end
  end

  scenario 'recover password' do
    visit '/'
    click_link 'Enter'
    click_link 'Forgot your password?'
    expect(current_path).to eq new_user_password_path
    fill_in 'Email', with: user.email

    expect do
      click_button 'Send me reset password instructions'
    end.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
