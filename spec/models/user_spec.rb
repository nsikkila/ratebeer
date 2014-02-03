require 'spec_helper'

describe User do
	it "has the username set correctly" do
		user = User.new username:"Pekka"

		user.username.should == "Pekka"
	end

	it "is not saved without a password" do
		user = User.create username:"Pekka"

		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved if password has only letters" do
		user = User.create username:"Pekka", password:"Abcdefg", password_confirmation:"Abcdefg"
	
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved with a too short password" do
		user = User.create username:"Pekka", password:"Ab1", password_confirmation:"Ab1"

		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	describe "favorite brewery" do
		let(:user){ FactoryGirl.create(:user) }

		it "has the method for determining one" do
			user.should respond_to :favorite_brewery
		end

		it "without ratings does not have one" do
			expect(user.favorite_brewery).to eq(nil)
		end

	end

	describe "favorite beer" do
		let(:user){ FactoryGirl.create(:user) }

		it "has the method for detemining one" do
			user.should respond_to :favorite_beer
		end

		it "without ratings does not have one" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the only rated if only one rating" do
			beer = create_beer_with_rating(10, user)

			expect(user.favorite_beer).to eq(beer)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings(10, 20, 7, 5, 22, user)
			best = create_beer_with_rating(25, user)
			

			expect(user.favorite_beer).to eq(best)
		end

	end

	describe "favorite style" do
		let(:user){ FactoryGirl.create(:user) }

		it "has the method for determining" do
			user.should respond_to :favorite_style
		end

		it "without ratings does not have one" do
			expect(user.favorite_style).to eq(nil)
		end

		it "is the only one rated if only one rating" do
			beer = create_beer_with_rating_and_style(10, user, "Lager")

			expect(user.favorite_style).to eq("Lager")
		end

		it "is the one with highest average rating if several rated" do
			create_beers_with_ratings_and_style(10, 20, 30, user, "Lager") #20
			create_beers_with_ratings_and_style(20, 50, 45, user, "Porter") #35
			create_beers_with_ratings_and_style(10, 20, user, "IPA") #15

			expect(user.favorite_style).to eq("Porter")
		end

	end

	describe "with a proper password" do
		let(:user){ FactoryGirl.create(:user) }

		it "is saved" do

			expect(user.valid?).to be(true)
			expect(User.count).to eq(1)
		end

		it "and two ratings, has the correct average rating" do

			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)

			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end

end

def create_beer_with_rating(score, user)
	beer = FactoryGirl.create(:beer)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings(*scores, user)
	scores.each do | score |
		create_beer_with_rating score, user
	end
end

def create_beer_with_rating_and_style(score, user, style)
	beer = FactoryGirl.create(:beer, style:style)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings_and_style(*scores, user, style)
	scores.each do | score |
		create_beer_with_rating_and_style score, user, style
	end
end