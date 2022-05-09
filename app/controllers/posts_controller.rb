class PostsController < ApplicationController
  before_action :validate
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
      unless @post.user == $current_user
        redirect_to home_path
      end
  end

  def new
    @post = Post.new
  end

  def edit
    if @posts.find_by(id: params[:id])
      unless @post.user == $current_user
        redirect_to home_path
      end
    end
  end

  def validate 
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def create
    @post = Post.new(post_params)
    @user = User.all
    
    @post.user = @user.find_by email: session[:email]
    respond_to do |format|
      if @post.save
        format.html { redirect_to home_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to home_path, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to home_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
