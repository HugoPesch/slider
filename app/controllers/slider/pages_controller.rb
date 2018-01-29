module Slider
  class PagesController < ApplicationController

    def index
    end

    def new
      @slider = Slider::Carrousel.new
    end

    def create
    end

    def import_image
    end

  end
end
