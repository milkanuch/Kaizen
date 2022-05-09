require 'net/http'
require 'uri'
require 'json'

class ProfileController < ApplicationController
    before_action :validate
    before_action :set_user, only: %i[update_user index]

    def index
        @posts = Post.all
    end

    def edit
    end
    
    def update_user
        @users = User.all
        
        firstname = params[:firstname]
        surname = params[:surname]
        nickname = params[:nickname]
        password = params[:password]

        avatar = params[:avatar]
        if(@users.find_by(nickname: nickname).nil?)
            $current_user.update(firstname: firstname, surname: surname,nickname: nickname,avatar: avatar)
            $current_user.save
            redirect_to edit_path
        else
            redirect_to home_path
            print "some validation... coming soon..."
        end
    end

    def validate 
        unless session[:user_id]
            redirect_to login_path
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end
end