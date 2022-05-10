class RoomsController < ApplicationController
    before_action :validate
    before_action :get_current_user 
    before_action :friends_search, only: %i[:index, :show]

    def index
        @message_friends = friends_search
    end

    def show 
        @user = User.find(params[:id])
        @messages = @user.messages

        @room_users = [@current_user.id,@user.id].sort!

        @room = Room.where(first_user_id:@room_users[0]  , second_user_id: @room_users[1]).first || Room.create_room(@room_users)
        
        @message_friends = friends_search
        
        @friend = @message_friends.find { |user| user.id == @user.id }
        
        @message = Message.new
        @messages = @room.messages.order(created_at: :asc)
        
        render 'index'
    end

    def get_current_user
        @users = User.all
        @current_user = @users.find_by email: session[:email]
        @current_user
    end 
    
    def friends_search 
        @users = User.all
        @message_friends = @users.select do |user|
            @current_user.friends.find_by(friend_id: user.id)
        end
        @message_friends
    end
    
    def validate 
        unless session[:user_id]
            redirect_to login_path
        end
    end
end
