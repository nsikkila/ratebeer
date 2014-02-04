require 'spec_helper'

describe "Ratings page" do

	it "can be accessed" do
		visit ratings_path

		expect(page).to have_content 'List of ratings'
	end

	describe "when ratings exist" do
		let!(:user){ FactoryGirl.create :user }
		let!(:beer1){ FactoryGirl.create :beer, name:'beer1'}
		let!(:beer2){ FactoryGirl.create :beer, name:'beer2'}
		let!(:rating1){ FactoryGirl.create :rating, user:user, beer:beer1}
		let!(:rating2){ FactoryGirl.create :rating, user:user, beer:beer2}

		it "lists all ratings and their total number" do
			visit ratings_path

			expect(page).to have_content 'beer1 10'
			expect(page).to have_content 'beer2 10'
			expect(page).to have_content 'Number of ratings: 2'
		end

	end
end