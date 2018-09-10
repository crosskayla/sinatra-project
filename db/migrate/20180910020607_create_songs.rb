class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :link
      t.integer :difficulty
      t.integer :progress
    end
  end
end
