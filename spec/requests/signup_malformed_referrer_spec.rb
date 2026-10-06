# frozen_string_literal: true

require "spec_helper"

describe "signup page with a non-string referrer param", type: :request do
  it "renders the signup page for a hash referrer" do
    get "http://#{DOMAIN}/signup?referrer[x]=1"

    expect(response).to have_http_status(:ok)
  end
end
