class ProvidersController < ApplicationController
    def index
        providers = Provider.get_all

        render json: providers
    end
end
