module Slider
  class CarrouselsController < ApplicationController
    before_action :set_slider, only: [:edit, :show, :update, :destroy]

    def index
      @sliders = Slider::Carrousel.all
    end

    def edit
      @galleries = Slider::Gallery.all
    end

    def show
    end

    def new
      @slider = Slider::Carrousel.new
      @galleries = Slider::Gallery.all
    end

    def create

      gallery = params.require(:carrousel).permit(:gallery)
      @gallery= gallery[:gallery].to_i

      puts @gallery.inspect

      @slider = Slider::Carrousel.new(slider_params)
      if @slider.save
        if @gallery > 0
          Slider::Gallery.find(@gallery).update(carrousel_id: @slider.id)
        end
        redirect_to carrousels_path, success: "Slider has correctly been created"
      else
        @galleries = Slider::Gallery.all
        render "new"
      end
    end

    def update

      currentGallery = Slider::Gallery.where(carrousel_id: @slider.id).select(:id)

      currentGallery.each do |gal|
        if !gal.id.nil?
          @currentGallery = gal.id
        else
          @currentGallery = nil
        end
      end

      modifGallery = params.require(:carrousel).permit(:gallery)
      @modifGallery = modifGallery['gallery'].to_i

      puts @currentGallery.inspect
      puts @modifGallery.inspect

      if @currentGallery != nil
        Slider::Gallery.find(@currentGallery).update(:carrousel_id => nil )
      end
      if @modifGallery == 0
        Slider::Gallery.find(@currentGallery).update(:carrousel_id => nil )
      else
        Slider::Gallery.find(@modifGallery).update(carrousel_id: @slider.id)
      end

      @slider.update(slider_params)
      redirect_to carrousels_path, success: "Slider has correctly been updated"

    end

    def destroy
      Slider::Gallery.where(carrousel_id: @slider.id).update_all(:carrousel_id => nil)
      @slider.destroy
      redirect_to carrousels_path, success: "Slider has correctly been destroyed"
    end

    private

    def slider_params
      params.require(:carrousel).permit(:carrouselName, :type_slide)
    end

    def set_slider
      @slider = Slider::Carrousel.find(params[:id])
    end

  end
end
