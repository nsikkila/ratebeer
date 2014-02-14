class PlacesController < ApplicationController


  def index

  end

  def search




      render :index
    end

  end

  private
  def use_cache
    true
  end

end