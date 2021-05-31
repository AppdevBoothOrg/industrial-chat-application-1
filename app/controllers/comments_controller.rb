# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments or /comments.json
  def index
    redirect_back fallback_location: root_url, alert: "You're not authorized for that."
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    redirect_back fallback_location: root_url, alert: "You're not authorized for that."
  end

  # GET /comments/new added @comment.author and @comment.conversation ehre now
  def new
    conversation_id = params['a_conversation_id']
    @conversation = Conversation.find_by(id: conversation_id) #All the issue is driven by this

  end

  # GET /comments/1/edit
  def edit
    redirect_back fallback_location: root_url, alert: "You're not authorized for that."
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.conversation = Conversation.find_by(id: params[:comment][:conversation_id])

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @comment.conversation, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:author_id, :body, :conversation_id)
  end
end
