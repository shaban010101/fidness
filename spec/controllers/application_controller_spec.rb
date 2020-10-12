require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    before_action :redirect_if_not_signed_in

    def create
      head :ok
    end
  end

  describe '#create' do
    context 'when the user has been signed in' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
        sign_in user
      end

      it 'responds successfully' do
        post :create
        expect(response.status).to eq(200)
      end
    end

    context 'when the user has not been signed in' do
      it 'redirects if the user is not signed in' do
        post :create
        expect(response.status).to eq(302)
      end
    end
  end
end