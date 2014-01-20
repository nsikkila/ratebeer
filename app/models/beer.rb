class Beer < ActiveRecord::Base
	belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = ratings.inject(0) { | sum, rating | sum + rating.score }
    sum.to_f / ratings.count
  end
end
