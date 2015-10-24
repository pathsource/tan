node(:projects) do
  @projects.map do |v|
    partial 'projects/project', object: v
  end
end