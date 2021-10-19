class PatientsController < ApplicationController
    def index
        patients = Patient.get_all

        render json: patients
    end

    def update

        Patient.edit(params[:patient])

        patients = Patient.get_all

        render json:patients
    end

    def destroy
        Patient.destroy(params[:id])
        
        # patients = Patient.get_all
        patients = Patient.get_with_providers


        render json:patients
    end

    def create
        Patient.create(params[:patient])

        patients = Patient.get_all

        render json:patients
    end
end
