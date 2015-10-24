collection :@projects

attributes :id, :name, :description, :sponsor, :address, :background, :image, :unit_type, :unit_steps_count

node(:distance) do |pro|
  "#{pro.distance([params[:coordinates].try(&:first).to_f, params[:coordinates].try(&:last).to_f])} km"
end