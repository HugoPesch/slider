module Slider
  class PagesController < ApplicationController

    def index
    end

    def new
      @slider = Slider.new
    end

  end
end
