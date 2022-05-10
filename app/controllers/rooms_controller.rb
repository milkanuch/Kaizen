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

        @room_name = get_name(@user.id, @current_user.id)
        @room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
        
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
    private

    def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0]}_#{user[1]}"
    end
end
