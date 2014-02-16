class PlacesController < ApplicationController


  def index

  end

  def show
    @place = BeermappingApi.places_in(session[:last_city]).select{ | place | place.id == params[:id]}
  end

  def search

    session[:last_city] = params[:city]
    @places = BeermappingApi.places_in(params[:city])


    if @places.empty?
      redirect_to places_path, notice:"No places in #{params[:city]}"
    else
      render :index
    end

  end

end