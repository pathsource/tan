class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.decimal :lat
      t.decimal :lon
      t.string :images, index: true, default: []

      t.timestamps null: false
    end
  end
end
