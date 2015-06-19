require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  it 'should only be able to leave one review per restaurant' do
    visit '/'
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
    click_link 'Review KFC'
    fill_in 'Thoughts', with:'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'so so, 3/5'
    click_link 'Review KFC'
    fill_in 'Thoughts', with:'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    p Review.count
    expect(page).to have_content "has reviewed this restaurant already"

    end
  end

  
end


