class RatingsController < ApplicationController
  

  def show
  end

  def index
    @ratings = Rating.all
  end

end

