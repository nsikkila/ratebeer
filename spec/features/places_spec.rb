require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do

    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, all are shown on the page" do

    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"), Place.new(:name => "Koljenorsi"), Place.new(:name => "Korsinolji")]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
    expect(page).to have_content 'Koljenorsi'
    expect(page).to have_content 'Korsinolji'
  end

  it "if none are returned by the API, notice is shown" do

    BeermappingApi.stub(:places_in).with('kumpula').and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'No places in kumpula'

  end
end