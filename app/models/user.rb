class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15}
  validates :password, length: { minimum: 4 }, format: { with: /\A.*[A-Z].*\z/, with:  /\A.*[0-9].*\z/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  	
  def favorite_beer
  	return nil if ratings.empty?

  	#yksi SQL-kysely, joka sisältää järjestämisen. suurella aineistolla nopeampi
  	ratings.order(score: :desc).limit(1).first.beer

  	#kaksi erillistä SQL-kyselyä ja järjestäminen muistissa
  	#ratings.sort_by{ | r | r.score }.last.beer
  end

  def favorite_style
  	return nil if ratings.empty?
  	ratings_by_style = ratings.group_by{ | rating | rating.beer.style }
  	solve_favorite_style(ratings_by_style)
  end

  def solve_favorite_style(ratings_by_style)
  	favorite_so_far = "None"
  	best_avg_so_far = -1.0

  	ratings_by_style.each do | row |
  		avg = row[1].inject(0){ | sum, rating | sum + rating.score }
  		if avg > best_avg_so_far
  			best_avg_so_far = avg
  			favorite_so_far = row[0]
  		end
  	end
  	favorite_so_far
  end
end