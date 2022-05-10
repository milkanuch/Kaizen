class ApplicationController < ActionController::Base
    def application
        @users = User.all
        @current_user = @users.find_by email: session[:email]
    end
end
