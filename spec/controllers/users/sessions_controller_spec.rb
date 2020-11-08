require 'rails_helper'

RSpec.describe Users::SessionsController do
  describe '#create' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'when the user has completed their answers' do
      let!(:answer) { FactoryBot.create(:answer, user: user) }

      context 'when the user is a trainer' do
        let(:user) { FactoryBot.create(:trainer) }

        it 'redirects the user to the trainer dashboard page' do
          post :create, params: {user: {email: user.email, password: user.password}}
          expect(response).to redirect_to(trainer_dasboard_path)
        end
      end
    end

    context 'when the user has not completed their answers' do
      let(:user) { FactoryBot.create(:user) }

      it "redirects to the /yourpath/ home page" do
        post user_session_path, params: {user: {email: user.email, password: user.password}}
        expect(response.location).to eq('')
        # expect(subject.send(:after_sign_in_path_for, user)).to eq(trainers_path)
      end
    end
  end
end