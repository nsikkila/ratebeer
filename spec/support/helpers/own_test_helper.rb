module OwnTestHelper

	def sign_in(credentials)
	    visit signin_path
	    fill_in('username', with:credentials[:username])
	    fill_in('password', with:credentials[:password])
	    click_button('Log in')
  	end

	def create_beer_with_rating(score, user)
		beer = FactoryGirl.create(:beer)
		FactoryGirl.create(:rating, score:score, beer:beer, user:user)
		beer
	end

	def create_beers_with_ratings(*scores, user)
		beers = Array.new
		scores.each do | score |
			beers << create_beer_with_rating(score, user)
		end
		beers
	end

	def create_beer_with_rating_and_style(score, user, style)
		beer = FactoryGirl.create(:beer, style:FactoryGirl.create(:style, name:style))
		FactoryGirl.create(:rating, score:score, beer:beer, user:user)
		beer
	end

	def create_beers_with_ratings_and_style(*scores, user, style)
		scores.each do | score |
			create_beer_with_rating_and_style score, user, style
		end
	end

end