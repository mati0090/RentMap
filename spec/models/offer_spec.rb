require 'spec_helper'
require 'rake'

describe Offer do

  it "should return hash for gmaps" do
    offer = Offer.create!(:latitude => 150.00, :longitude => 90.00, :price => 1500, :link => "http://gumtree.pl/offer")

    offer.to_marker_hash.should == {:latitude=>150.0, :longitude=>90.0, :title=>"1500", :content=>"http://gumtree.pl/offer"}
  end

  describe "Parsing" do
    it "should parse offer with correct address" do
      offer = Offer.parse_from_gumtree("#{Rails.root}/spec/support/offer_with_address.html")

      offer.latitude.should  == 99.9999
      offer.longitude.should == 11.1111
      offer.price.should     == 1100
    end

    it "should call geocoder method correct" do
      Geocoder.should_receive(:coordinates).with(/Al. Street Addr 115, City, Polska/)

      Offer.parse_from_gumtree("#{Rails.root}/spec/support/offer_with_address.html")
    end

    it "should not parse offer without full address" do
      offer = Offer.parse_from_gumtree("#{Rails.root}/spec/support/offer_without_address.html")

      offer.should be_nil
    end

    it "should skip non-offer page" do
      GumtreeParser.any_instance.stub(:open).and_return("not-correct-html-site")

      Offer.parse_from_gumtree("").should == nil
    end

    describe "Rake tasks" do
      before(:each) do
        @rake = Rake::Application.new
        Rake.application = @rake
        load "#{Rails.root}/lib/tasks/gumtree.rake"
        Rake::Task.define_task(:environment)
      end

      it "should parse links from rss gumtree channel" do
        Offer.should_receive(:parse_from_gumtree).with("http://link-1.gumtree.pl")
        Offer.should_receive(:parse_from_gumtree).with("http://link-2.gumtree.pl")
        Offer.should_receive(:parse_from_gumtree).with("http://link-3.gumtree.pl")

        Rake::Task['parse:gumtree'].invoke("spec/support/rss_channel.xml")
      end
    end
  end
end
