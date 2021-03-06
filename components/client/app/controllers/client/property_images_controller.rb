require_dependency 'admin/application_controller'

module Client
  class PropertyImagesController < ApplicationController
    before_action :set_property

    def index
    end

    def new
      @image = @property.images.new
    end

    def create
      @image = @property.images.new(set_params)
      @image.save
      flash[:success] = t :success
    end


    def destroy
      @image = @property.images.find(params[:id])
      @image.destroy
      flash[:success] = t :success
      redirect_to action: :index
    end

    private

    def set_property
      @property = Property.where(customer_id: current_user.id).find(params[:property_id])
    end

    def set_params
      params.require(:property_image).permit(:propety_id, :name, :image, :publish, :order)
    end
  end
end