collection :@projects

attributes :id, :name, :description, :sponser, :address, :background, :image

node(:distance) do |pro|
  pro.distance([params[:coordinates].try(&:first).to_f, params[:coordinates].try(&:last).to_f])
end