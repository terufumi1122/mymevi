require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :request do

  before do
    @location = FactoryBot.create(:location)
  end

  describe "GET #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "returns http success" do
      patch :update, params: { id: @location.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      delete :destroy, params: { id: @location.id } 
      expect(response).to have_http_status(:success)
    end
  end

end
