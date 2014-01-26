class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true, öength: { minimum: 3}

  has_many :ratings

end
