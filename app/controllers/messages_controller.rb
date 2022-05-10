class MessagesController < ApplicationController
    before_action :validate

    def create
        @users = User.all
        @current_user = @users.find_by email: session[:email]
        if msg_params[:content].length > 0
            @message = @current_user.messages.create(message_body: msg_params[:content], room_id: params[:room_id])
            redirect_back(fallback_location: :home_path)
        else 
            puts "Message is empty"
        end
    end

    def validate 
        unless session[:user_id]
            redirect_to login_path
        end
    end

    private
    def msg_params
        params.require(:message).permit(:content)
    end
end