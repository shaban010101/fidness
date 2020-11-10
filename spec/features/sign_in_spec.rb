require 'rails_helper'

RSpec.describe 'Sign In', type: :feature do
  context 'when the user enters the incorrect credentials' do
    it 'does not sign the user in to their account' do
      visit(new_user_session_path)
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(find('.alert').text).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end