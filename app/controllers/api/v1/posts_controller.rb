class Api::V1::PostsController < ApplicationController

  def index
    posts = Post.all
    render json: posts, each_serializer: Posts::IndexSerializer
  end

  def create
    post = Post.create(post_params)
  
    if post.persisted?
      render json: { message: 'Successfully created', id: post.id}
    else
      render json: { error: post.errors.full_messages }, status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :category, :longitude, :latitude, keys: [:image])
  end 
 
end