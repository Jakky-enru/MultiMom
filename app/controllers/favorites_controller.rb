class FavoritesController < ApplicationController
  def create
    favorite_comment = current_user.favorites.create!(user_id: current_user.id, comment_id: params[:comment_id])
    redirect_to blog_path(params[:blog_id])
  end

  def destroy
    blog_id = Comment.find(Favorite.find(params[:id]).comment_id).blog_id
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blog_path(blog_id)
  end
end
