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
  	ratings.first.beer.style
  end

end
