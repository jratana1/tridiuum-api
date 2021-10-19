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
        record = params[:record].except(:id, :mrn)
        Provider.create(record)

        provider_id = Provider.get_last.getvalue(0,0)

        params[:associations].each do |association|
            Provider.associate("hospital", "provider", association[:id], provider_id)
        end

        providers = Provider.get_all

        render json:providers
    end


end
