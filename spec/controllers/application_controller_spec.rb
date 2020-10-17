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

  describe '#redirect_if_user_cannot_access_session' do
    controller do
      before_action -> { redirect_if_user_cannot_access_session('future_sessions') }

      def create
        head :ok
      end

      def session
        @session = Session.find(params[:id])
      end
    end


    let(:user) { FactoryBot.create(:user) }
    let(:trainer) { FactoryBot.create(:trainer) }
    let(:purchased_session) { FactoryBot.create(:purchased_session, user: user, trainer: trainer) }
    let(:session) { FactoryBot.create(:session, purchased_session: purchased_session, availability: availability) }
    let(:availability) { FactoryBot.create(:availability, user: trainer)}

    context 'when the user can access the session' do
      context 'when the user is a client' do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in user
        end

        context 'when the user can access the session' do
          it 'goes to the page requested' do
            post(:create, params: {id: session.id})
            expect(response.status).to eq(200)
          end
        end
      end

      context 'when the user is a trainer' do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in trainer
        end

        it 'goes to the page requested' do
          post(:create, params: {id: session.id})
          expect(response.status).to eq(200)
        end
      end
    end

    context 'when the user cannot access the session' do
      let(:another_user) { FactoryBot.create(:user) }

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in another_user
      end

      it 'redirects to the page specified' do
        post(:create, params: { id: session.id })
        expect(response.status).to eq(302)
        expect(response).to redirect_to(future_sessions_path)
      end
    end
  end
end