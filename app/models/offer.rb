require "gumtree_parser"

class Offer < ActiveRecord::Base
  attr_accessible :latitude, :link, :longitude

  def self.parse_from_gumtree(address)
    gumtree_parser = GumtreeParser.new(address)

    Offer.create!(:latitude => gumtree_parser.latitude,
                  :longitude => gumtree_parser.longitude,
                  :link => address) if gumtree_parser.parseable?
  end
end
