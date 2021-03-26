class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit publish update destroy ]
  #validates :text, presence: true

  # GET /posts or /posts.json
  def index
    @posts = Post.where(parent_post_id: nil, status:'published').or(Post.where(parent_post_id:nil, user_id: current_user.id, status: 'draft'))
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if params[:parent_post_id].present? 
      @post = Post.new(parent_post_id: params[:parent_post_id], status: 'published')
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  def publish
    if @post.status == 'draft'
      @post.status = 'published'
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "Post was successfully published." }
          format.json { render :show, status: :published, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    entity = "Post"

    respond_to do |format|
      if @post.save
        unless @post.parent_post_id == nil
          @post = Post.find(@post.parent_post_id)
          entity = "Comment"
        end
        format.html { redirect_to @post, notice: "#{entity} was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.status = 'deleted'
    @post.save
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:text, :link, :user_id, :parent_post_id)
    end
end
