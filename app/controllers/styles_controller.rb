class StylesController < ApplicationController

  def index
    @styles = Style.all
  end

  def show
    @style = Style.find params[:id]
  end

  def edit
    @style = Style.find params[:id]
  end
end
