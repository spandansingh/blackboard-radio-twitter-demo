class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]


  # POST /likes or /likes.json
  def create
    @like = Like.new({post_id: params[:post_id], user_id: current_user.id})

    respond_to do |format|
      if @like.save
        if params[:parent_post_id].present?
          format.html { redirect_to "/posts/#{params[:parent_post_id]}", notice: "Post has been successfully liked" }
        else
          format.html { redirect_to '/posts', notice: "Post has been successfully liked" }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      if params[:parent_post_id].present?
          format.html { redirect_to "/posts/#{params[:parent_post_id]}", notice: "Post has been successfully unliked" }
      else
        format.html { redirect_to '/posts', notice: "Post has been successfully unliked" }
      end
      
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end
end
