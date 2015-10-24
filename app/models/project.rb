class Project < ActiveRecord::Base

	has_many :participations
	has_one :puzzle
  has_many :comments

  def distance(coordinates)
    coordinates ||= []
    return 0 if coordinates.map(&:to_i) == [0, 0]
    num = Geocoder::Calculations.distance_between(coordinates, [lat.to_f, lon.to_f]).round(1)
    # "#{num} km"
  end
  
end
