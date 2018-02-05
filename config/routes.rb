Slider::Engine.routes.draw do

  root "pages#index"

  resources :uploads, only: [:index, :create, :destroy] do
    collection do
      get :list #list_upload_url
    end
  end

  resources :carrousels
  resources :galleries


end
