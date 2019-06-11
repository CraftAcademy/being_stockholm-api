class Api::V0::PingsController < ApplicationController
  def index
    render json: { message: 'Pong' }
  end
end