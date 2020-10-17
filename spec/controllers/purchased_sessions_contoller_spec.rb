require 'rails_helper'

RSpec.describe PurchasedSessionsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user) { FactoryBot.create(:user) }
  let(:trainer) { FactoryBot.create(:trainer) }
  let(:purchased_session) { FactoryBot.create(:purchased_session, user: user, trainer: trainer) }

  describe '#show' do
    context 'when the user can access the purchased session' do
      before do
        sign_in user
      end

      it 'displays the purchased session page' do
        get :show, params: { id: purchased_session.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user cannot access the purchased session' do
      let(:another_user) { FactoryBot.create(:user) }

      before do
        sign_in another_user
      end

      it 'redirects shows a not found page' do
        get :show, params: { id: purchased_session.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end