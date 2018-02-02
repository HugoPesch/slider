Slider::Engine.routes.draw do

  resources :uploads, only: [:index, :create, :destroy] do
    collection do
      get :list #list_upload_url
    end
  end
  
  root to:"pages#index"
  get  "pages", to: "pages#index"
  get  "pages/index", to:"pages#index"
  get  "pages/new", to: "pages#new", as: "new"

  get  "pages/new/gallery", to: "pages#add_gallery", as: "new_gallery"
  post "pages/new/gallery", to: "pages#create_gallery", as:"create_gallery"
  get  "pages/new/gallery/upload-images", to:"pages#upload_images", as:"upload_images"
  get  "pages/new/image/upload-images", to: "pages#upload_images"

end
