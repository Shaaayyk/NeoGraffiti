class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_request, except: %i[index show index_by_user]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  def index_by_user
    @user = User.find(params[:user_id])
    posts = @user.posts
    render json: posts, status: :ok
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  # def create
  #   @post = Post.new(post_params)

  #   if @post.save
  #     render json: @post, status: :created, location: @post
  #   else
  #     render json: @post.errors, status: :unprocessable_entity
  #   end
  # end

  def create_by_user
    user = User.find(params[:user_id])
    post = Post.new(post_params)
    if post.save
      render json: {post: post}, status: :created
    else
      render json: {error: post.errors}, status: :unprocessible_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :image, :content)
    end
end