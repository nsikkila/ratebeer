require 'spec_helper'
include OwnTestHelper

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

		it "is the only rated if only one rating" do
			brewery = FactoryGirl.create(:brewery)
			beer = create_beer_with_rating(10, user)
			brewery.beers << beer

			expect(user.favorite_brewery).to eq(brewery)
		end

		it "is the one with highest average rating if several rated" do
			brewery1 = FactoryGirl.create(:brewery, name:"brewery1")
			brewery2 = FactoryGirl.create(:brewery, name:"brewery2")
			brewery3 = FactoryGirl.create(:brewery, name:"brewery3")
			brewery1.beers << create_beers_with_ratings(10,20,30, user)
			brewery2.beers << create_beers_with_ratings(30,40,50, user)
			brewery3.beers << create_beers_with_ratings(20,30,40, user)

			expect(user.favorite_brewery).to eq(brewery2)

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
