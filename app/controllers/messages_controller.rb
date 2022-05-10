class MessagesController < ApplicationController
    before_action :validate

    def create
        @message = $current_user.messages.create(message_body: msg_params[:content], room_id: params[:room_id])
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