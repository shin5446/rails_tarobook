Rails.application.routes.draw do
  get '/', to: 'top_page#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
