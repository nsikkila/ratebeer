require 'spec_helper'

describe Beer do

	it "is not saved without a name" do
		beer = Beer.create style:"Lager"

		expect(beer.valid?).to be(false)
		expect(Beer.count).to eq(0)
	end

  	describe "with proper name and style" do
  		let(:beer){ Beer.create name:"Testiolut", style:"Lager" }

	  	it "is saved" do
	  		expect(beer.valid?).to be(true)
	  		expect(Beer.count).to eq(1)
	  	end
	end
end
