class User < ActiveRecord::Base
  has_secure_password
  has_many :user_songs
  has_many :songs, through: :user_songs

  def name
    if self.first_name && self.last_name
      self.first_name + " " + self.last_name
    else
      self.username
    end
  end
  
end
