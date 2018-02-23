module Slider
  class GalleriesController < ApplicationController

    # l'action à effectuer avant les appels edit, show, update, destroy
    # Récupération des informations sur la gallery actuel
    before_action :set_gallery, only: [ :edit, :show, :update, :destroy]

=begin
    Appel de la page index.html.erb
    avec envois de la liste des galleries existantes
=end

    def index
      @galleries = Slider::Gallery.all
    end

=begin
  Appel de la page edit.html.erb
  avec envois de la liste des images n'appartennent  pas à la gallery
=end

    def edit
      @images = Slider::Upload.where("slider_uploads.id NOT IN (SELECT upload_id FROM slider_orders WHERE gallery_id = #{@gallery.id})")
    end

=begin
  Méthode d'affichage de la gallery, par l'action Ajax de la page Edit.html.erb, script dynamic_uploads.js.erb
=end

    def show
        @gallery = Slider::Gallery.find(params[:id])
        render :layout => false
    end

=begin
  Appel de la page new.html.erb
  Instantiation d'une nouvelle gallery
  Envois des images
=end

    def new
      @gallery = Slider::Gallery.new
      @images = Slider::Upload.all
    end

=begin
  Methode de création de la gallery
=end

    def create

      #Récupération des images passé en paramètre
      uploads = params.require(:gallery).permit(:uploads=>[])
      #Exclusion des champs vides du tableau retourné
      @uploads= uploads[:uploads].reject { |c| c.empty?}

      @orderH = Hash.new

      # Récupération de l'ordre des images
      @orderH = params.require(:gallery).require(:order)

      # Création de la gallery avec les paramètres
      @gallery = Slider::Gallery.new(gallery_params)

      #sauvegarde de la gallery
      if @gallery.save
        #Définition de l'ordre de l'image
        @uploads.each do |image|
          if @orderH[image]["order"].to_i == 0
            @order = nil
          else
            @order = @orderH[image]["order"].to_i
          end
          #Remplissage du champs order dans la table slider_orders, puis sauvegarde de la gallery
          @order = Slider::Order.new(upload_id: image, gallery_id: @gallery.id, order: @order)
          @order.save
        end
        redirect_to galleries_path, success: "Gallery has correctly been created"
      else
        @images = Slider::Upload.all
        render "new"
      end
    end

=begin
  Méthode de mise à jours de gallery
=end

    def update
      #Récupération des images courrente de la gallery
      currentImages = Slider::Upload.joins(:orders).where(slider_orders: {gallery_id: params[:id]}).select(:id)
      @currentImages = []
      currentImages.each do |im|
        @currentImages.push(im.id)
      end

      #Récupération de la liste des images postées
      modifImages = params.require(:gallery).permit(:uploads=>[])
      @modifImages =  modifImages[:uploads].reject { |c| c.empty?}

      #Vérification de l'action image effectué
      @intModif = @modifImages.collect{ |s| s.to_i }
      @imagesDif = @currentImages -  @intModif
      @imagePlus = @intModif - @currentImages

      #Récupération de l'ordre
      @orderH = Hash.new
      @orderH = params.require(:gallery).require(:order)

      # Vérification suppression des images, puis suppression des uploads de la gallery des images retirées
      if !@imagesDif.nil?
          @imagesDif.each do |id|
            Slider::Gallery.find(@gallery.id).uploads.destroy(id)
          end
      end

      #Vérification de l'ajout d'images, puis insertion dans la table order de la liaison
      if !@imagePlus.nil?
        @imagePlus.each do |id|
          if @orderH[id] == 0
            @order = nil
          else
            @order = @orderH[id]
          end
          #sauvegarde des ordres des nouvelles images
          @nOrder = Slider::Order.new(upload_id: id, gallery_id: @gallery.id, order: @order)
          @nOrder.save
        end
      end
      #Mise à jours de l'ordre des images
      @orderH.each do |upload, order|
        Slider::Order.find_by(upload_id: upload, gallery_id: @gallery.id).update(order: order[:order])
      end

      # Mise à jours de la gallery
      @gallery.update(gallery_params)
      redirect_to galleries_path, success: "Gallery has correctly been updated"

    end

=begin
  Methode de suppression de gallery
  suppression des slider_orders de la gallery suprimée
  puis suppression de la gallery
=end

    def destroy
      Slider::Order.where(gallery_id: @gallery.id).destroy_all
      @gallery.destroy
      redirect_to galleries_path, success: "Gallery has correctly been destroyed"
    end

    private

    #récupèration des paramètre de la gallery
    def gallery_params
      params.require(:gallery).permit(:slider_carrousel_id, :galleryName)
    end

    #définition de la gallery courante, passé en paramètre
    def set_gallery
      @gallery = Slider::Gallery.find(params[:id])
    end
  end
end
