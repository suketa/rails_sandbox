require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    let!(:user) { User.create!({name: 'Taro'}) }
    it "returns a success response" do
      get :index, as: :json
      expect(response).to be_successful
      expect(response.parsed_body).not_to be_kind_of(String)
      expect(response.parsed_body).to be_kind_of(Array)
      expect(response.parsed_body.first['name']).to eq(user.name)
    end
  end
end
