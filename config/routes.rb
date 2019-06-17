Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :pings, only: [:index], constraints: { format: 'json' }
    end

    namespace :v1 do
      resources :posts, only: [:index, :create, :show]
    end
  end
end
