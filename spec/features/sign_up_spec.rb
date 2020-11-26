require 'rails_helper'

RSpec.describe 'Sign up', type: :feature do
  context 'when the user signs up successfully' do
    it 'signs the user in' do
      visit 'users/sign_up'
      within '.container.sign-up' do
        fill_in 'user_email', with: Faker::Internet.safe_email
        find(:css, '#user_type').find(:option, 'Client').select_option
        password = Faker::Lorem.characters(number: 10)
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password
        find("input[type='checkbox'][value='1']").set(true)
        click_button 'Sign up'
        expect(page).to have_current_path(new_profile_path)
      end
    end
  end

  context 'when the user does not sign up' do
    it 'stays on the sign up page' do
      visit 'users/sign_up'
      within '.container.sign-up' do
        fill_in 'user_email', with: Faker::Internet.safe_email
        find(:css, '#user_type').find(:option, 'Client').select_option
        click_button 'Sign up'
        expect(find('.alert').text).to eq("×\nThis form contains 2 errors.\nPassword can't be blank Terms and conditions must be accepted to sign up")
      end
    end
  end
end