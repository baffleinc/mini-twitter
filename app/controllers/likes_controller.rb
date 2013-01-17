class LikesController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @like = Like.create(params[:like])
    @micropost = @like.micropost
    respond_with @micropost
  end

  def destroy
    @like = Like.find(params[:id]).destroy
    @micropost = @like.micropost
    respond_with @micropost
  end
end
