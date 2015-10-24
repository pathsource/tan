class RenameSponsorColumn < ActiveRecord::Migration
  def change
    rename_column :projects, :sponser, :sponsor
  end
end
