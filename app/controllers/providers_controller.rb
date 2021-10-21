class ProvidersController < ApplicationController
    def index
        # need to get hospital associations
        providers = Provider.get_with_hospitals

        render json: providers
    end

    def show
        provider = Provider.show(params[:id])

        render json: provider
    end

    def update
        record = params[:record].except(:hospitals, :count)
        Provider.edit(record)

        #get all associations from join table
        all_assoc = Provider.get_all_associations("hospital", record[:id])

        #Delete associations not in params update
        all_assoc.entries.each do |association|
            if !(params[:associations].any? {|h| h["id"] == association["hospital_id"]})
                HospitalProvider.destroy(association["id"])
            end
        end
        #Insert update, method ensures uniqueness
        params[:associations].each do |association|
            Provider.associate("hospital", "provider", association[:id], record[:id])
        end

        providers = Provider.get_with_hospitals

        render json:providers
    end

    def destroy
        Provider.destroy(params[:id])
        
        providers = Provider.get_with_hospitals

        all_assoc = Provider.get_all_associations("hospital", params[:id])
        all_assoc.entries.each do |association|
                HospitalProvider.destroy(association["id"])
        end

        all_assoc = Provider.get_all_associations("patient", params[:id])
        all_assoc.entries.each do |association|
                PatientProvider.destroy(association["id"])
        end

        render json:providers
    end

    def create
        record = params[:record].except(:id, :mrn)
        Provider.create(record)

        provider_id = Provider.get_last.getvalue(0,0)

        params[:associations].each do |association|
            Provider.associate("hospital", "provider", association[:id], provider_id)
        end

        providers = Provider.get_with_hospitals

        render json:providers
    end


end
