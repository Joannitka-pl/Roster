module LoginMacros

  def login user
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def logout
    click_link 'Log out'
  end

end