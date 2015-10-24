class Project < ActiveRecord::Base

	has_many :participations
	has_one :puzzle

  def distance(coordinates)
    coordinates ||= []
    num = Geocoder::Calculations.distance_between(coordinates, [lat.to_f, lon.to_f]).round(1)
    # "#{num} km"
  end
  
end
