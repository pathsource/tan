class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :content
      t.string :answer
      t.integer :project_id
      t.string :hint

      t.timestamps null: false
    end
  end
end
