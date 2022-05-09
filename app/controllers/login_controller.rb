require 'net/http'
require 'uri'
require 'json'

class LoginController < ApplicationController
    layout false

    def index
        if session[:user_id]
            
        end
    end

    def signin
        email = params[:e_mail]
        password = params[:password]

        uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCfh28igRRSymoEp3-dVDNKe1PnlIFdXlk")

        response = Net::HTTP.post_form(uri,email: email,password: password)
        
        data = JSON.parse(response.body)

        if response.is_a?(Net::HTTPSuccess)
            session[:email] = email
            session[:user_id] = data["localId"]
            redirect_to home_path
        else 
            redirect_to action: "index"
        end
    end

    def signup
        firstname = params[:reg_firstname]
        surname = params[:reg_surname]
        nickname = params[:reg_nickname]
        email = params[:reg_email]
        password = params[:reg_password]

        uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCfh28igRRSymoEp3-dVDNKe1PnlIFdXlk")

        response = Net::HTTP.post_form(uri,email: email,password: password)
        data = JSON.parse(response.body)
        
        if response.is_a?(Net::HTTPSuccess)
            session[:email] = email
            session[:user_id] = data["localId"]
            @user = User.new(firstname: firstname, surname: surname, nickname: nickname,email: email)
            @user.save 
            redirect_to home_path
        else 
            redirect_to action: "index"
        end
    end

    def signout 
        session.clear
        puts "logout?"
        redirect_to action: "index"
    end

    def user_params
        params.require(:user).permit(:firstname, :surname, :nickname, :email, :password)
    end
end
