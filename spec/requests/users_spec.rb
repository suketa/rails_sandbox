require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    let!(:user) { User.create(name: 'Taro') }
    it "returns a success response" do
      get users_path, as: :json
      expect(response).to have_http_status(200)
      expect(response.parsed_body).not_to be_kind_of(String)
      expect(response.parsed_body).to be_kind_of(Array)
      expect(response.parsed_body.first['name']).to eq(user.name)
    end
  end
end
