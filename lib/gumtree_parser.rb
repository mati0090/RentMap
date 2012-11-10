require 'nokogiri'
require 'open-uri'

class GumtreeParser
  attr_reader :latitude, :longitude, :price

  def initialize(address)
    doc = Nokogiri::HTML(open(address))

    @street_address = parse_street_address(parse_from_cell_name(doc, "Adres"))
    @price          = parse_price(parse_from_cell_name(doc, "Cena"))

    @latitude, @longitude = geocode(@street_address) if parseable?
  end

  def parseable?
    @parseable ||= street_address_correct?(@street_address)
  end

  private
    ADDRESS_REGEXP  = /([a-z-. ]+)\s+([0-9]+)/
    PRICE_REGEXP    = /[0-9, ]{4,13}/

    def street_address_correct?(street_address)
      return false if street_address.nil?
      address_parts = street_address.split(",")

      address_parts.first =~ ADDRESS_REGEXP
    end

    def geocode(street_address)
      Geocoder.coordinates(street_address)
    end

    def parse_from_cell_name(doc, cell_name)
      doc.search("//td[contains(text(), \"#{cell_name}\")]/../td[2]").first.text
    rescue
      nil
    end

    def parse_price(price)
      price.scan(PRICE_REGEXP).first.delete(' ').to_i
    rescue
      nil
    end

    def parse_street_address(street_address)
      street_address.lines.first
    rescue
      nil
    end
end