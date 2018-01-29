Slider::Engine.routes.draw do

  root to:"pages#index"
  get  "pages", to: "pages#index"
  get  "pages/index", to:"pages#index"
  get  "pages/new", to: "pages#new"

end
