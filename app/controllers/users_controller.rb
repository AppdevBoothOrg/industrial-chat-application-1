class UsersController < ApplicationController
  before_action :set_user
  before_action :ensure_current_user_logged_in, only: %i[ show ]

  def show
  end
  
  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end
    
    def ensure_current_user_logged_in
      if current_user != @user
        redirect_back fallback_location: root_url, alert: "You're not authorized for that."
      end
    end

end