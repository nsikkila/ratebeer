class Beer < ActiveRecord::Base
	belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = 0
    count = 0
    ratings.each do |rating|
      sum += rating.score
      count += 1
    end
    1.0*sum / count
  end
end
