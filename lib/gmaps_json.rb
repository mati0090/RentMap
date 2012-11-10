module Enumerable
  def to_gmaps_markers_hash
    markers = []
    each do |object|
      markers << object.to_marker_hash
    end

    markers
  end
end