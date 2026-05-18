# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home" do
  describe "GET /home" do
    it "h1 に 'Rails APP' を表示する" do
      get "/home"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("<h1>Rails APP</h1>")
    end

    it "'Login with singpass' ボタンが /oidc/start に遷移する" do
      get "/home"
      expect(response.body).to include("Login with singpass")
      expect(response.body).to include('action="/oidc/start"')
    end
  end
end
