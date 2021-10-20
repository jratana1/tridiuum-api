class PatientsController < ApplicationController
    def index
        patients = Patient.get_with_providers

        render json:patients
    end

    def update
        record = params[:record].except(:providers)
        Patient.edit(record)

        #get all associations from join table
        all_assoc = Patient.get_all_associations("provider", record[:id])

        #Delete associations not in params update
        all_assoc.entries.each do |association|
            if !(params[:associations].any? {|h| h["id"] == association["provider_id"]})
                PatientProvider.destroy(association["id"])
            end
        end
        #Insert update, method ensures uniqueness
        params[:associations].each do |association|
            Patient.associate("patient", "provider", record[:id], association[:id])
        end

        patients = Patient.get_with_providers

        render json:patients
    end

    def destroy
        Patient.destroy(params[:id])
      
        patients = Patient.get_with_providers

        render json:patients
    end

    def create
        record = params[:record].except(:id)
        Patient.create(record)

        patient_id = Patient.get_last.getvalue(0,0)

        params[:associations].each do |association|
            Patient.associate("patient", "provider", patient_id, association[:id])
        end

        patients = Patient.get_with_providers

        render json:patients
    end
end
