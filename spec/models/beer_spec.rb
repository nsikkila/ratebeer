require 'spec_helper'

BeerClub
BeerClubsController
MembershipsController

describe Beer do

	it "is not saved without a name" do
		beer = Beer.create style:"Lager"

		expect(beer.valid?).to be(false)
		expect(Beer.count).to eq(0)
	end

	it "is not saved without a style" do
		beer = Beer.create name:"Testbeer"

		expect(beer.valid?).to be(false)
		expect(Beer.count).to eq(0)
	end

  	describe "with proper name and style" do
  		let(:beer){ Beer.create name:"Testbeer", style:"Lager" }

	  	it "is saved" do
	  		expect(beer.valid?).to be(true)
	  		expect(Beer.count).to eq(1)
	  	end
	end
end
