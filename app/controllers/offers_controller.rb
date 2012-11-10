require 'gmaps_json'

class OffersController < ApplicationController
  def index
    respond_to do |respond|
      respond.html {render :index}
      respond.json {render :json => Offer.all.to_gmaps_markers_hash}
    end
  end
end
