class UserSongs < ActiveRecord::Migration
  def change
    create_table :user_songs do |t|
      t.integer :user_id
      t.integer :song_id
    end
  end
end
