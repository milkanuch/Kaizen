class RoomsController < ApplicationController
    before_action :validate
    before_action :friends_search, only: %i[:index, :show]

    def index
        @message_friends = friends_search
    end

    def show 
        @user = User.find(params[:id])
        @messages = @user.messages
        
        @room = Room.where(first_user_id: $current_user.id, second_user_id: @user.id).first || Room.create_private_room([$current_user, @user])
        @message_friends = friends_search
        
        @message = Message.new
        @messages = @room.messages.order(created_at: :asc)
        
        render 'index'
    end
    
    def friends_search 
        @users = User.all
        @message_friends = @users.select do |user|
            $current_user.friends.find_by(friend_id: user.id)
        end
        @message_friends
    end
    
    def validate 
        unless session[:user_id]
            redirect_to login_path
        end
    end
end
