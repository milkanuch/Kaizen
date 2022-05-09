class MessagesController < ApplicationController
    before_action :validate
    before_action :friends_search

    def index
        
    end

    def show 
        @user = User.find(params[:id])
        @messages = @user.messages

        unless Room.find_by(first_user_id: $current_user.id, second_user_id: @user.id)
            @rooms = Room.new(first_user_id:$current_user.id, second_user_id: @user.id)
            @rooms.save 
        end

        @room = Room.find_by(first_user_id: $current_user.id, second_user_id: @user.id)
        @message = Message.new

        render 'index'
    end

    def create
        @message = $current_user.messages.build(content: params[:content], room_id: params[:id])
    end
    
    def friends_search 
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