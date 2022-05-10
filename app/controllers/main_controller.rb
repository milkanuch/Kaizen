class MainController < ApplicationController
  before_action :validate
  before_action :get_current_user
  before_action :friend_params, only: [:follow]

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new

    @users = User.all
    @user = User.new

    @current_user = @users.find_by email: session[:email]
    @friends = @current_user.friends

    unless @current_user.nil?
      @users = User.where.not(id: @current_user.id)
    end
  end

  def follow
    unless @current_user.friends.find_by(friend_params)
      @friend = Friend.new(friend_params)
      @friend.save
    end
    redirect_to home_path
  end

  def get_current_user
    @users = User.all
    @current_user = @users.find_by email: session[:email]
    @current_user
  end

  def validate 
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def unfollow
    if @current_user.friends.find_by(friend_params)
      @friend = Friend.find_by(friend_params)
      @friend.destroy
    end
    redirect_to home_path
  end

  def friend_params
    params.require(:friend).permit(:friend_id, :user_id)
  end
end
