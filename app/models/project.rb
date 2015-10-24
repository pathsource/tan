class Project < ActiveRecord::Base

  def distance(coordinates)
    coordinates ||= []
    num = Geocoder::Calculations.distance_between(coordinates, [lat.to_f, lon.to_f])
    "#{num} km"
  end
  
end
