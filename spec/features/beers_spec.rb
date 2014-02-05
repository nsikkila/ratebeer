require 'spec_helper'
include OwnTestHelper

describe "Beer" do
	before :each do
		FactoryGirl.create(:brewery)
    FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
		visit new_beer_path
	end

	it "when given a valid name, is added to the system" do
		fill_in('beer_name', with:'Testiolut')
		click_button "Create Beer"

		expect(Beer.count).to eq(1)
	end

	it "when given an invalid name, redirected to beer creation form" do
		fill_in('beer_name', with:'')
		click_button "Create Beer"

		expect(current_path).to eq(beers_path)
		expect(page).to have_content 'error prohibited this beer from being saved:'
		expect(Beer.count).to eq(0)
	end
end
