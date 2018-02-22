module Slider
  class UploadsController < ApplicationController

    #Appel de la page index avec création d'un nouvel objet uploads
    def index
      @upload = Slider::Upload.new
    end

=begin
  Méthode d'appel du champ  text_field sur la page order.html.erb lors de la selection des images de la page création/édition de la gallery
  Récupération de l'id de gallery, (édition) préchagement des images qui font déjà partie de la gallery si le params[:idGallery] !.nil?, sinon (création) envois de toutes les images
=end

    def order
      if !params[:idGallery].nil?
        @idGallery = params[:idGallery]
        @uploads= Slider::Upload.select(:id, :image_file_name, :order).joins("LEFT JOIN slider_orders ON slider_orders.upload_id = slider_uploads.id AND slider_orders.gallery_id = #{params[:idGallery]}").where(id: params[:id]).order("slider_orders.order")
      else
        @uploads = Slider::Upload.where(id: params[:id])
      end
      render :layout => false
    end

    #affichage sur la page la liste des images enregistrées
    def image_list
      @imagesList = Slider::Upload.all
    end

    #Methode de création et sauvegarde des images
    def create
      @upload = Slider::Upload.new(upload_params)

      if @upload.save
        render json: {message: "success",  uploadId: @upload.id}, status: 200
      else
        render json: {error: @upload.errors.full_messages.join(", ")}, status: 400
      end
      puts @upload.inspect
    end

=begin
  Methode de suppression d'images
  suppression de tous champs dans slider_orders oû l'image est attriuée
=end

    def destroy
      Slider::Upload.find(params[:id]).orders.destroy_all
      @upload = Slider::Upload.find(params[:id])

      if @upload.destroy
        render json: {message: "file deleted from server" }
      else
        render json: {message: @image.errors.full_messages.join(", ")}
      end
    end

=begin
   List upload affiche la liste des images déjà enregistrer
=end

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

    #définition des paramètres de l'image
    def upload_params
       params.require(:upload).permit(:image)
    end
  end
end
