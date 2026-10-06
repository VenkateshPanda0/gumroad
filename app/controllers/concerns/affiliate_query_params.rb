# frozen_string_literal: true

module AffiliateQueryParams
  def fetch_affiliate_id(params)
    raw_id = params[:affiliate_id].presence || params[:a].presence
    # ?affiliate_id[x]=1 or ?a[][]=1 parse to a Hash or nested Array, which has no #to_i.
    first = Array.wrap(raw_id).first
    return nil unless first.is_a?(String)

    id = first.to_i
    id.zero? ? nil : id
  end
end
