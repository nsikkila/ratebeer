require 'spec_helper'

describe "User page" do
	let!(:user1){ FactoryGirl.create :user }
	let!(:user2){ FactoryGirl.create :user, username:'user2'}
	let!(:beer1){ FactoryGirl.create :beer, name:'beer1', style:FactoryGirl.create(:style, name:"IPA")}
	let!(:beer2){ FactoryGirl.create :beer, name:'beer2'}
	let!(:beer3){ FactoryGirl.create :beer, name:'beer3', style:FactoryGirl.create(:style, name:"Lager")}
	let!(:rating1){ FactoryGirl.create :rating2, user:user1, beer:beer1}
	let!(:rating2){ FactoryGirl.create :rating, user:user2, beer:beer2}
	let!(:rating3){ FactoryGirl.create :rating, user:user1, beer:beer3}
	
	it "shows all users own ratings and their total number" do
		sign_in(username:"Pekka", password:"Foobar1")
		visit user_path(user1)

		expect(page).to have_content 'beer1 20'
		expect(page).to have_content 'beer3 10'
		expect(page).to have_content 'Has made 2 ratings'
	end

	it "does not show other users ratings" do
		sign_in(username:"Pekka", password:"Foobar1")
		visit user_path(user1)

		expect(page).not_to have_content 'beer2'
		expect(page).to have_content 'Has made 2 ratings'
	end

	it "can be used to delete a rating" do
		sign_in(username:"Pekka", password:"Foobar1")
		visit user_path(user1)	
		

		within ".ratingList" do
			click_link("Delete", :match => :first)
		end

		expect(user1.ratings.count).to eq(1)	
	end

	it "shows favorite brewery" do
		visit user_path(user1)

		expect(page).to have_content 'Favorite brewery: anonymous'
	end

	it "shows favorite style" do
		visit user_path(user1)

		expect(page).to have_content 'Favorite style: IPA'
	end
end