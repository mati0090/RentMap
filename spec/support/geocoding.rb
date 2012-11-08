google_json = <<-JSON
{
  "status": "OK",
  "results": [ {
    "types": [ "street_address" ],
    "address_components": [{"long_name": "291-1", "short_name": "291-1", "types": ["street_address"]}, {"long_name": "Gwancheol-dong", "short_name": "Gwancheol-dong", "types": ["sublocality", "political"]}, {"long_name": "Jongno-gu", "short_name": "Jongno-gu", "types": ["sublocality", "political"]}, {"long_name": "Seoul", "short_name": "Seoul", "types": ["locality", "political"]}, {"long_name": "South Korea", "short_name": "KR", "types": ["country", "political"]}, {"long_name": "110-111", "short_name": "110-111", "types": ["postal_code"]}],
    "formatted_address": "South Korea, Seoul, Jongno-gu, Gwancheol-dong, 291-1",
    "location_type": "ROOFTOP",
    "geometry": {
      "location": {
        "lat": 99.9999,
        "lng": 11.1111
      }
    }
  } ]
}
JSON

FakeWeb.register_uri(:any, %r|http://maps\.googleapis\.com/maps/api/geocode|, :body => google_json)