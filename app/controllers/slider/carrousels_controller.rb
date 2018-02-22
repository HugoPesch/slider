module Slider
  class CarrouselsController < ApplicationController
    # l'action à effectuer avant les appels edit, show, update, destroy
    # Récupération des informations sur le slider actuel
    before_action :set_slider, only: [:edit, :show, :update, :destroy]

=begin
    Appel de la page index.html.erb
    avec envois de la liste des carrousel existant
=end
    def index
      @sliders = Slider::Carrousel.all
    end
=begin
    Appel de la page edit.html.erb
    avec envois de la liste des galleries
=end
    def edit
      @galleries = Slider::Gallery.all
    end

    def show
    end
=begin
  Appel de la page new.html.erb
  Instantiation d'un nouveau carrousel
  envois de la liste des galleries
=end
    def new
      @slider = Slider::Carrousel.new
      @galleries = Slider::Gallery.all
    end
=begin
  Après validation, méthode de création de carrousel
=end
    def create
      # Récupération du param de la gallery, du carrousel
      gallery = params.require(:carrousel).permit(:gallery)

      # convertion de l'id de gallery en integer
      @gallery = gallery[:gallery].to_i

      puts @gallery.inspect


      #D'éfinition du type de slider
      if slider_params[:type_slide] == "carrouselHor"
        @img_class = {"img_class" => "img-hor"}
      else
        @img_class = {"img_class" => "img-ver"}
      end
      @slider_params = slider_params.merge(@img_class)

      # création du carrousel avec les paramètres
      @slider = Slider::Carrousel.new(@slider_params)

      #sauvegarde du carrousel dans la base de données
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

=begin
  Action de mise à jours du carrousel
=end

    def update
      #On récupère l'id de la gallery présente
      currentGallery = Slider::Gallery.where(carrousel_id: @slider.id).select(:id)

      #Vérification de l'attribution d'une gallery
      currentGallery.each do |gal|
        if !gal.id.nil?
          @currentGallery = gal.id
        else
          @currentGallery = nil
        end
      end

      #Récupération de la gallery séléctionnée

      modifGallery = params.require(:carrousel).permit(:gallery)
      @modifGallery = modifGallery['gallery'].to_i

      # Redéfinition des champs de la gallery du carrousel lors de la modification
      if @currentGallery != nil
        Slider::Gallery.find(@currentGallery).update(:carrousel_id => nil )
      end

      # Vérification de la modification de gallery
      if @modifGallery == 0
        Slider::Gallery.find(@currentGallery).update(:carrousel_id => nil )
      else
        Slider::Gallery.find(@modifGallery).update(carrousel_id: @slider.id)
      end

=begin
  Modification du type de slider
=end

      if slider_params[:type_slide] == "carrouselHor"
        @img_class = {"img_class" => "img-hor"}
      else
        @img_class = {"img_class" => "img-ver"}
      end

      @slider_params = slider_params.merge(@img_class)

      #Mise à jours du carrousel
      @slider.update(@slider_params)
      redirect_to carrousels_path, success: "Slider has correctly been updated"

    end

=begin
  Methode de suppression de carrousel
=end

    def destroy
      # Libération de la gallery du carrousel, puis suppression
      Slider::Gallery.where(carrousel_id: @slider.id).update_all(:carrousel_id => nil)
      @slider.destroy
      redirect_to carrousels_path, success: "Slider has correctly been destroyed"
    end

    private

    #Récupération des paramètres du carrousel
    def slider_params
      params.require(:carrousel).permit(:carrouselName, :type_slide)
    end

    #Récupération du carrousel passé en paramètre
    def set_slider
      @slider = Slider::Carrousel.find(params[:id])
    end

  end
end
