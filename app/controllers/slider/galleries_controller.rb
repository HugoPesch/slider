module Slider
  class GalleriesController < ApplicationController

    before_action :set_gallery, only: [ :edit, :show, :update, :destroy]

    def index
      @galleries = Slider::Gallery.all
    end

    def edit
      @images = Slider::Upload.where("slider_uploads.id NOT IN (SELECT upload_id FROM slider_orders WHERE gallery_id = #{@gallery.id})")
    end

    def show
        @gallery = Slider::Gallery.find(params[:id])
        render :layout => false
    end

    def new
      @gallery = Slider::Gallery.new
      @images = Slider::Upload.all
    end

    def create
      uploads = params.require(:gallery).permit(:uploads=>[])
      @uploads= uploads[:uploads].reject { |c| c.empty?}

      @gallery = Slider::Gallery.new(gallery_params)

      if @gallery.save
        @uploads.each do |image|
          @order = Slider::Order.new(upload_id: image, gallery_id: @gallery.id)
          @order.save
        end
        redirect_to galleries_path, success: "Gallery has correctly been created"
      else
        @images = Slider::Upload.all
        render "new"
      end
    end

    def update

      currentImages = Slider::Upload.joins(:orders).where(slider_orders: {gallery_id: params[:id]}).select(:id)

      @currentImages = []
      currentImages.each do |im|
        @currentImages.push(im.id)
      end

      modifImages = params.require(:gallery).permit(:uploads=>[])
      @modifImages =  modifImages[:uploads].reject { |c| c.empty?}

      @intModif = @modifImages.collect{ |s| s.to_i }
      @imagesDif = @currentImages -  @intModif
      @imagePlus = @intModif - @currentImages

      if !@imagesDif.nil?
          @imagesDif.each do |id|
            puts ("TABLE IMAGE DIF")
            puts @imagesDif.inspect
            Slider::Gallery.find(@gallery.id).uploads.destroy(id)
          end
      end

      if !@imagePlus.nil?
        @imagePlus.each do |id|
          @nOrder = Slider::Order.new(upload_id: id, gallery_id: @gallery.id)
          @nOrder.save
        end
      end

      @gallery.update(gallery_params)
      redirect_to galleries_path, success: "Gallery has correctly been updated"

    end

    def destroy
      Slider::Order.where(gallery_id: @gallery.id).destroy_all
      @gallery.destroy
      redirect_to galleries_path, success: "Gallery has correctly been destroyed"
    end

    private

    def gallery_params
      params.require(:gallery).permit(:slider_carrousel_id, :galleryName)
    end

    def set_gallery
      @gallery = Slider::Gallery.find(params[:id])
    end
  end
end
