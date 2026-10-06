# frozen_string_literal: true

require "spec_helper"

describe "product page with a non-scalar affiliate param", type: :request do
  let(:seller) { create(:user) }
  let(:product) { create(:product, user: seller) }

  it "renders the product page for a hash affiliate_id" do
    get "http://#{seller.subdomain}/l/#{product.unique_permalink}?affiliate_id[x]=1"

    expect(response).to have_http_status(:ok)
  end

  it "renders the product page for a nested array a param" do
    get "http://#{seller.subdomain}/l/#{product.unique_permalink}?a[][]=1"

    expect(response).to have_http_status(:ok)
  end
end
