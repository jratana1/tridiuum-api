class ProvidersController < ApplicationController
    def index
        providers = Provider.get_all

        render json: providers
    end

    def update

        Provider.edit(params[:provider])

        providers = Provider.get_all

        render json:providers
    end

    def destroy
        Provider.destroy(params[:id])
        
        providers = Provider.get_all

        render json:providers
    end

    def create
        Provider.create(params[:provider])
        providers = Provider.get_all

        render json:providers
    end
end
