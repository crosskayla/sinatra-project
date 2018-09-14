class AddProgress < ActiveRecord::Migration
  def change
    remove_column :songs, :progress, :integer
  end
end
