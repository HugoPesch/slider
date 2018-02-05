module Slider
  class CarrouselsController < ApplicationController
    before_action :set_slider, only: [ :edit, :show, :update, :destroy]

    def index
      @sliders = Slider::Carrousel.all
    end

    def edit
    end

    def show
    end

    def new
      @slider = Slider::Carrousel.new
    end

    def create
      @slider = Slider::Carrousel.new(slider_params)
      if @slider.save
        redirect_to carrousels_path, success: "Slider has correctly been created"
      else
        render "new"
      end
    end

    def update
      @slider.update(slider_params)
      redirect_to carrousels_path, success: "Slider has correctly been updated"
    end

    def destroy
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
