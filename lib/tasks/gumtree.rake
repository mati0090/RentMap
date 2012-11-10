require 'open-uri'

namespace :parse do
  desc "Downloads offers from links given in RSS address parameter"
  task :gumtree, :rss_addr do |t, args|
    rss_addr = args[:rss_addr]

    rss = SimpleRSS.parse open(rss_addr)

    rss.items.each do |item|
      Offer.parse_from_gumtree(item.link)
    end
  end
end