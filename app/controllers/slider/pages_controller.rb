module Slider
  class PagesController < ApplicationController

    def index
    end

    def new
      @slider = Slider::Carrousel.new
    end

    def add_gallery
      @gallery = Slider::Gallery.new
    end

    def create_gallery
      @gallery = Slider::Gallery.new(params.require(:gallery).permit(:galleryName))
      if @gallery.valid?
        @gallery.save
        redirect_to drop_image_path, success: "Gallery create"
      else
        render 'add_gallery'
      end
    end

    def edit_gallery
    end

    def drop_images
    end


  end
end
