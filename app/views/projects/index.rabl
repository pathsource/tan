collection :@projects

attributes :id, :name, :description, :sponsor, :address, :background, :image

node(:distance) do |pro|
  "#{pro.distance([params[:coordinates].try(&:first).to_f, params[:coordinates].try(&:last).to_f])} km"
end