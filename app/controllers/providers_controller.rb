class ProvidersController < ApplicationController
    def index
        render json: Provider.all
    end
end
