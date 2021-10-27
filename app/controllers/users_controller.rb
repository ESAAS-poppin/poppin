class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def index
    end

    def new
        @user = User.new
    end 

    def show
       @user = current_user
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
          session[:user_id] = @user.id
          redirect_to @user
        else
          flash[:error] = "Error creating account."
          redirect_to new_user_path
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "You have signed out"
        redirect_to new_session_path
    end

    # private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def user_params
       params.require(:user).permit(:username, :password, :age, :id)
    end
end
