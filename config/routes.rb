Slider::Engine.routes.draw do

  root to:"pages#index"
  get  "pages", to: "pages#index"
  get  "pages/index", to:"pages#index"
  get  "pages/new", to: "pages#new", as: "new"

  get  "pages/new/gallery", to: "pages#add_gallery", as: "new_gallery"
  post "pages/new/gallery", to: "pages#create_gallery", as:"create_gallery"
  get  "pages/new/gallery/drop-images", to:"pages#drop_images", as:"drop_images"

end
