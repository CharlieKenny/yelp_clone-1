module Helpers
    def sign_up (email, password)
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: email)
      fill_in('Password', with: password)
      fill_in('Password confirmation', with: password)
      click_button('Sign up')
  end

  def create_rest
    visit '/restaurants'
    sign_up('test@test.com', 'password')
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
  end
end