require 'spec_helper'


describe "Beer" do
	before :each do
		FactoryGirl.create(:brewery)
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

		save_and_open_page
		expect(Beer.count).to eq(0)
		
		expect(current_path).to eq(new_beer_path)

	end
end
