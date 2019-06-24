class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:create, :update]

  def index
    posts = Post.all
    render json: posts, each_serializer: Posts::IndexSerializer
  end

  def show
    post = Post.find(params[:id])
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

  def update
    post = Post.find(params[:id])
    if current_api_v1_user.admin == true && post.pending? == true
      post.update(status: params[:status])
      if post.status == params[:status] && post.pending? == false
        render json: { message: 'Post status successfully updated' }, status: 200
      else
        render json: { error: 'There was a problem updating the status of the post' }
      end
    else
      render json: { error: 'You do not have sufficient privileges to perform this action' }, status: 422
    end
  end

  private

  def post_params
    params.permit(:caption, :category, :longitude, :latitude, :user_id, keys: [:image])
  end 

  def attach_image  
    if params['image'] && params['image'].present?
      DecodeImageService.attach_image(params['image'], @post.image)
    end
  end

end