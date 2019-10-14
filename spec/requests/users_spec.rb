require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(response.media_type).to eq('text/html')
      expect(response).to have_http_status(200)
    end
  end
end
