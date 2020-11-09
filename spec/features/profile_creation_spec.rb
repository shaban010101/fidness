require 'rails_helper'

RSpec.describe 'Profile creation', type: :feature do
  before do
    login_as(user, :scope => :user)
    visit(new_profile_path)
  end

  context 'when the user is a client' do
    let(:user) { create :user }

    context 'when the required fields are entered' do

      it 'redirects the user to the trainers page' do
        within('form') do
          find(:css, "input[id$='first_name']").set(Faker::Name.first_name)
          find(:css, "input[id$='last_name']").set(Faker::Name.last_name)
          find("#answer-0").find(:option, 'Get stronger').select_option
          find("#answer-1").find(:option, '2-3 days').select_option
          find("#answer-2").find(:option, '4-5 days').select_option
          find("#answer-3").set('N/A')
          find("#answer-4").set('N/A')
          find("#answer-5").set('N/A')
          find("#answer-6").find(:option, 'Female').select_option
          click_button 'Submit'
          expect(page).to have_current_path(trainers_path)
        end
      end
    end

    context 'when the required fields are not entered' do
      it 'outputs an error on the page with the missing fields' do
        click_button 'Submit'
        expect(find('.alert').text).to have_content('This form contains 5 errors.')
        expect(page).to have_current_path('/profile')
      end
    end
  end

  context 'when the user is a trainer' do
    let(:user) { create :trainer }

    context 'when the required fields are entered' do
      it 'redirects the user to the trainer dashboard page' do
        within('form') do
          find(:css, "input[id$='first_name']").set(Faker::Name.first_name)
          find(:css, "input[id$='last_name']").set(Faker::Name.last_name)
          attach_file 'avatar', 'spec/fixtures/fake.jpg'
          fill_in 'profile_price', with: 100
          fill_in 'profile_short_description', with: Faker::Lorem.characters(number: 25)
          fill_in 'profile_long_description', with: Faker::Lorem.characters(number: 125)
          fill_in 'profile_qualifications', with: Faker::Lorem.characters(number: 50)
          find("#answer-0").find(:option, 'Yoga').select_option
          find("#answer-1").find(:option, '5+ years').select_option
          click_button 'Submit'
          expect(page).to have_current_path('/profile/new')
        end
      end

      context 'when the required fields are not entered' do
        it 'outputs an error on the page with the missing fields' do
          click_button 'Submit'
          expect(find('.alert').text).to have_content('This form contains 8 errors.')
          expect(page).to have_current_path('/profile')
        end
      end
    end
  end
end