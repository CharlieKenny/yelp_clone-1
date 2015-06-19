require 'rails_helper'
require_relative '../helpers/helpers'

include Helpers

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_content'You need to sign to add restaurants!'
    end
  end

  context 'restaurants have been added' do
    scenario 'display restaurants' do
      create_rest
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      create_rest
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      sign_up('test@test.com', 'password')
      click_link 'Add a restaurant'
      fill_in 'Name', with:'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do

  scenario 'lets a user view a restaurant' do
    visit '/restaurants'
    sign_up('test@test.com', 'password')
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
    click_link 'KFC'
    new_restaurant = Restaurant.where(name: 'KFC').first
    expect(current_path).to eq "/restaurants/#{new_restaurant.id}"
  end
end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      create_rest
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do 

    scenario 'removes a restaurant when a user clicks a delete link' do
      create_rest
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context "cannot edit and delete restaurants" do
    scenario "that I haven't created" do
      sign_up('test@test.com', 'password')
      click_link 'Sign out'
      sign_up('test2@test.com', 'password')
      expect(page).not_to have_content 'Edit KFC'
      expect(page).not_to have_content 'Delete KFC'
    end
  end

  # context "can edit and delete restaurants" do
  #   scenario "that I have created" do
  #     visit '/'
  #     sign_up
  #     click_link 'Add a restaurant'
  #     fill_in 'Name', with: 'KFC'
  #     click_button 'Create Restaurant'
  #     expect(page).to have_content 'Edit KFC'
  #     expect(page).to have_content 'Delete KFC'
  #   end
  # end

end



