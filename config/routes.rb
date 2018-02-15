Slider::Engine.routes.draw do

  root "pages#index"

  resources :uploads, only: [:index, :create, :destroy] do
    collection do
      get :list #list_upload_url
    end
  end


  post "uploads/order", to: "uploads#order", as: "order"
  get "uploads/image-list", to: "uploads#image_list", as: "image_list"

  resources :carrousels
  resources :galleries
  resources :orders


end
