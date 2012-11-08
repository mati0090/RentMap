require 'nokogiri'
require 'open-uri'

class GumtreeParser
  attr_reader :latitude, :longitude

  def initialize(address)
    doc = Nokogiri::HTML(open(address))

    @street_address = parse_from_cell_name(doc, "Adres").lines.first

    @latitude, @longitude = geocode(@street_address) if parseable?
  end

  def parseable?
    @parseable ||= verify_address(@street_address)
  end

  private
    ADDRESS_REGEXP = /([a-z-. ]+)\s+([0-9]+)/

    def verify_address(street_address)
      address_parts = street_address.split(",")

      address_parts.first =~ ADDRESS_REGEXP
    end

    def geocode(street_address)
      Geocoder.coordinates(street_address)
    end

    def parse_from_cell_name(doc, cell_name)
      doc.search("//td[contains(text(), \"#{cell_name}\")]/../td[2]").first.text
    end
end