class AddUnitToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :unit_type, :string
    add_column :projects, :unit_steps_count, :integer
  end
end
