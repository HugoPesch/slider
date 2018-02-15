module Slider
  class UploadsController < ApplicationController

    def index
      @upload = Slider::Upload.new
    end

    def order
      if !params[:idGallery].nil?
        @idGallery = params[:idGallery]
        @uploads= Slider::Upload.select(:id, :image_file_name, :order).joins(:orders).where(id: params[:id], slider_orders: {gallery_id: params[:idGallery]}).order("slider_orders.order")

      else
        @uploads = Slider::Upload.where(id: params[:id])
      end
      render :layout => false
    end

    def image_list
      @imagesList = Slider::Upload.all
    end

    def create
      @upload = Slider::Upload.new(upload_params)

      if @upload.save
        render json: {message: "success",  uploadId: @upload.id}, status: 200
      else
        render json: {error: @upload.errors.full_messages.join(", ")}, status: 400
      end
      puts @upload.inspect
    end

    def destroy
      Slider::Upload.find(params[:id]).orders.destroy_all
      @upload = Slider::Upload.find(params[:id])

      if @upload.destroy
        render json: {message: "file deleted from server" }
      else
        render json: {message: @image.errors.full_messages.join(", ")}
      end
    end

    def list
    		uploads = []
    		Slider::Upload.all.each do |upload|
    			new_upload = {
    				id: upload.id,
    				name: upload.image_file_name,
    				size: upload.image_file_size,
    				src: upload.image(:thumb)
    			}
    			uploads.push(new_upload)
    		end
    		render json: { images: uploads }
    end

    private

    def upload_params
       params.require(:upload).permit(:image)
    end
  end
end
