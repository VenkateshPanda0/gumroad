# frozen_string_literal: true

require "spec_helper"

describe "product page with a non-string quantity param", type: :request do
  let(:seller) { create(:user) }
  let(:product) { create(:product, user: seller) }
  let(:product_url) { "http://#{seller.subdomain}/l/#{product.unique_permalink}" }

  it "renders the product page for an array quantity" do
    get "#{product_url}?quantity[]=2"

    expect(response).to have_http_status(:ok)
  end

  it "renders the product page for a hash quantity" do
    get "#{product_url}?quantity[a]=2"

    expect(response).to have_http_status(:ok)
  end

  it "redirects a wanted product to checkout without the malformed quantity" do
    get "#{product_url}?wanted=true&quantity[]=2"

    expect(response).to have_http_status(:redirect)
    expect(Rack::Utils.parse_nested_query(URI.parse(response.location).query)).not_to have_key("quantity")
  end

  it "still passes a string quantity through to checkout" do
    get "#{product_url}?wanted=true&quantity=2"

    expect(Rack::Utils.parse_nested_query(URI.parse(response.location).query)["quantity"]).to eq("2")
  end
end
