# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show edit update destroy]

  # GET /conversations or /conversations.json
  def index
    redirect_back fallback_location: root_url, alert: "You're not authorized for that."
    @conversations = Conversation.all
  end

  # GET /conversations/1 or /conversations/1.json
  def show
    if current_user != @conversation.customer && current_user != @conversation.company_representative
      redirect_back fallback_location: root_url, alert: "You're not authorized for that."
    end
  end

  # GET /conversations/new some alterations here
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
    redirect_back fallback_location: root_url, alert: "You're not authorized for that."
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.save
    
    the_first_comment = @conversation.comments.create(
      body: "Hello, how can I help you today?",
      author_id: current_user.id
      )
  
    #conversation_params[:conversation][:comment_id] = the_first_comment.id
    
    @conversation.open!
    @conversation.comment_id = the_first_comment.id

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1 or /conversations/1.json
  def update
    
    if params['status'] != nil
      
      the_status = params['status']
      if the_status == 'open'
        @conversation.open!
      elsif the_status == 'closed'
        @conversation.close!
      else 
        @conversation.urgent!
      end

    end

    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def conversation_params
    params.require(:conversation).permit(:company_representative_id, :customer_id, :comment_id, :status)
  end
end
