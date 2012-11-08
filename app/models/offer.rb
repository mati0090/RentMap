require "gumtree_parser"

class Offer < ActiveRecord::Base
  attr_accessible :latitude, :link, :longitude, :price

  def self.parse_from_gumtree(address)
    gumtree_parser = GumtreeParser.new(address)

    Offer.create!(:latitude => gumtree_parser.latitude,
                  :longitude => gumtree_parser.longitude,
                  :price => gumtree_parser.price,
                  :link => address) if gumtree_parser.parseable?
  end
end
