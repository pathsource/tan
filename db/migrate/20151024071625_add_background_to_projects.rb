class AddBackgroundToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :background, :string
    add_column :projects, :sponser, :string
    rename_column :projects, :images, :image
  end
end
