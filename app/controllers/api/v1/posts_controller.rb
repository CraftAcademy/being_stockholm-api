class Api::V1::PostsController < ApplicationController

  def index
    posts = Post.all
    render json: posts, each_serializer: Posts::IndexSerializer
  end

  def show
    @post = Post.find(params[:id])
    render json: post, serializer: Posts::ShowSerializer
  end

  def create
    @post = Post.create(post_params)
    attach_image

    if @post.persisted? && @post.image.attached?
      render json: { message: 'Successfully created', id: @post.id }
    else
      render json: { error: @post.errors.full_messages }, status: 422
    end

  end



  private

  def post_params
    params.permit(:caption, :category, :longitude, :latitude, keys: [:image])
  end 

  def attach_image  
    if params['image'] && params['image'].present?
      DecodeImageService.attach_image(params['image'], @post.image)
    end
  end

end