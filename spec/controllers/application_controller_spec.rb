require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#redirect_if_not_signed_in' do
    controller do
      before_action :redirect_if_not_signed_in

      def create
        head :ok
      end
    end

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

  describe '#redirect_if_not_trainer' do
    controller do
      before_action :redirect_if_not_trainer

      def create
        head :ok
      end
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    context 'when the user is a trainer signed in' do
      let(:user) { FactoryBot.create(:user) }

      it 'responds successfully' do
        post :create
        expect(response.status).to eq(302)
      end
    end

    context 'when the user has not been signed in' do
      let(:user) { FactoryBot.create(:user, :trainer) }

      it 'redirects if the user is not signed in' do
        post :create
        expect(response.status).to eq(200)
      end
    end
  end
end