require 'rails_helper'

RSpec.describe Api::V1::RoundsController, type: :controller do
  let!(:round) { create(:round) }
  let!(:match) { create(:match, round:) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: round.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new Round' do
      expect do
        post :create, params: { round: attributes_for(:round) }
      end.to change(Round, :count).by(1)
    end
  end

  describe 'PUT #update' do
    it 'updates the requested round' do
      put :update, params: { id: round.to_param, round: { name: 'Updated Name' } }
      round.reload
      expect(round.name).to eq('Updated Name')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested round' do
      expect do
        delete :destroy, params: { id: round.to_param }
      end.to change(Round, :count).by(-1)
    end
  end
end
