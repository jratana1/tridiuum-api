class ProvidersController < ApplicationController
    def index
        providers = Provider.get_providers

        render json: providers
    end
end
