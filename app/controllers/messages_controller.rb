class MessagesController < ApplicationController
    before_action :validate
    def index
        @friends = $current_user.friends
        @users = User.all
        @message_friends = @users.select do |user|
            @friends.find_by(friend_id: user.id)
        end
    end

    def validate 
        unless session[:user_id]
            redirect_to login_path
        end
    end
end