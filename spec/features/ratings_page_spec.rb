require 'spec_helper'

describe "Ratings page" do

	it "can be accessed" do
		visit ratings_path

		expect(page).to have_content 'List of ratings'
	end

	describe "when ratings exist" do
		let!(:user1){ FactoryGirl.create :user }
		let!(:user2){ FactoryGirl.create :user, username:'user2'}
		let!(:beer1){ FactoryGirl.create :beer, name:'beer1'}
		let!(:beer2){ FactoryGirl.create :beer, name:'beer2'}
		let!(:beer3){ FactoryGirl.create :beer, name:'beer3'}
		let!(:rating1){ FactoryGirl.create :rating, user:user1, beer:beer1}
		let!(:rating2){ FactoryGirl.create :rating, user:user2, beer:beer2}
		let!(:rating3){ FactoryGirl.create :rating, user:user1, beer:beer3}

		it "lists all ratings and their total number" do
			visit ratings_path

			expect(page).to have_content 'beer1 10'
			expect(page).to have_content 'beer2 10'
			expect(page).to have_content 'beer3 10'
			expect(page).to have_content 'Number of ratings: 3'
		end

	end
end
