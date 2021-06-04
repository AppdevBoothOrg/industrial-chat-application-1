class RatingsController < ApplicationController
  before_action :set_rating, only: %i[show edit update destroy]

  def show
  end

  def index
    @ratings = Rating.all
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to conversation_path(@rating.conversation), notice: 'Rating was successfully updated.' }
      end
    end
  end

  # POST /conversations or /conversations.json
  def create
    @rating = Rating.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to conversation_path(@rating.conversation), notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rating_params
    params.require(:rating).permit(:grader_id, :gradee_id, :grade, :conversation_id)
  end
end

